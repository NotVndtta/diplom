class VineyardAuthController < ApplicationController
  def create
    uri = URI("https://dev.digitalwinery.ru/auth/api/sign_in")

    request = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
    request.body = {
      email: params[:email],
      password: params[:password]
    }.to_json

    begin
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(request)
      end
    rescue SocketError, Errno::ECONNREFUSED, Net::OpenTimeout => e
      Rails.logger.error "Network error: #{e.message}"
      flash.now[:alert] = "Сервер авторизации недоступен. Попробуйте позже."
      return render :new
    end

    unless response.is_a?(Net::HTTPSuccess)
      Rails.logger.warn "Auth failed with status #{response.code}: #{response.body}"

      # Можно вытащить сообщение об ошибке, если API его возвращает
      begin
        error_json = JSON.parse(response.body)
        message = error_json.dig("errors", 0, "detail") || "Неверный email или пароль"
      rescue JSON::ParserError
        message = "Ошибка авторизации. Проверьте email и пароль."
      end

      flash.now[:alert] = message
      return render :new
    end

    begin
      parsed = JSON.parse(response.body)
      user_data = parsed.dig("data", "attributes")
      included = parsed["included"] || []

      tenant_data = included.find { |item| item["type"] == "tenant" }&.dig("attributes")

      user = User.find_or_create_by(email: user_data["email"]) do |u|
        u.password = params[:password]
        u.password_confirmation = params[:password]

        u.first_name = user_data["first_name"]
        u.last_name = user_data["last_name"]
        u.phone = user_data["phone_number"]
        u.birth_year = 2000
        u.city = "Не выбран"
        u.role = "admin"
      end

      user.update(
        vineyard_token: user_data["auth_token"],
        first_name: user_data["first_name"],
        last_name: user_data["last_name"],
        phone: user_data["phone_number"]
      )

      sign_in(user)
      redirect_to root_path, notice: "Успешный вход через Vineyard!"
    rescue JSON::ParserError => e
      Rails.logger.error "Ошибка парсинга JSON: #{e.message}"
      flash.now[:alert] = "Ошибка обработки ответа от сервера авторизации"
      render :new
    rescue => e
      Rails.logger.error "Ошибка в логике create: #{e.message}"
      flash.now[:alert] = "Что-то пошло не так при входе. Попробуйте снова."
      render :new
    end
  end
end
