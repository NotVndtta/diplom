require "net/http"
require "uri"
require "json"

class VineyardAuthController < ApplicationController
  def new
  end

  def create
    uri = URI("http://localhost:3001/auth/api/sign_in")

    request = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
    request.body = {
      email: params[:email],
      password: params[:password]
    }.to_json

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      begin
        Rails.logger.info "Raw response from auth service: #{response.body}"

        parsed = JSON.parse(response.body)
        parsed = JSON.parse(parsed) if parsed.is_a?(String)

        user_data = parsed["data"]["attributes"]
        jwt = user_data["auth_token"]

        unless jwt
          flash.now[:alert] = "Не получен токен авторизации"
          return render :new
        end

        user = User.find_or_create_by(email: user_data["email"]) do |u|
          u.first_name = user_data["first_name"]
          u.last_name = user_data["last_name"]
          u.password = Devise.friendly_token[0..19]
        end

        user.update(vineyard_token: jwt)
        sign_in(user)
        redirect_to root_path, notice: "Signed in with Vineyard!"
      rescue JSON::ParserError => e
        Rails.logger.error "JSON parse error: #{e.message}"
        flash.now[:alert] = "Ошибка разбора данных от сервера авторизации"
        render :new
      end
    else
      Rails.logger.warn "Auth failed with status #{response.code}: #{response.body}"
      flash.now[:alert] = "Authentication failed"
      render :new
    end
  end
end
