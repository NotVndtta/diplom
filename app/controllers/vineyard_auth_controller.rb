require 'net/http'
require 'uri'
require 'json'

class VineyardAuthController < ApplicationController
  def new
  end

  def create
    uri = URI("https://auth.vineyard.com/api/sign_in")
    request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    request.body = {
      email: params[:email],
      password: params[:password]
    }.to_json

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      user_data = JSON.parse(response.body)["data"]["attributes"]
      jwt = user_data["auth_token"]

      user = User.find_or_create_by(email: user_data["email"]) do |u|
        u.first_name = user_data["first_name"]
        u.last_name = user_data["last_name"]
        u.password = Devise.friendly_token[0..19]
      end

      user.update(vineyard_token: jwt)
      sign_in(user)
      redirect_to root_path, notice: "Signed up with Vineyard!"
    else
      flash.now[:alert] = "Authentication failed"
      render :new
    end
  end
end
