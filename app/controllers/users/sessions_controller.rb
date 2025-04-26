# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :html, :turbo_stream

  def create
    self.resource = warden.authenticate(auth_options)
    if resource && resource.active_for_authentication?
      sign_in(resource_name, resource)
      flash[:notice] = "Вы успешно вошли в систему!"
      redirect_to after_sign_in_path_for(resource)
    else
      self.resource = resource_class.new(sign_in_params)
      resource.valid?
      flash.now[:alert] = resource.errors.full_messages.join(", ") if resource.errors.any?
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "new_user_session_form",
            template: "devise/sessions/new",
            locals: { resource: resource }
          )
        end
      end
    end
  end
end
