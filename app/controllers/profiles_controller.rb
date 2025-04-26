class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update job_cards foreman_description]
  before_action :authenticate_user!, only: %i[edit update foreman_description]
  before_action :authorize_user, only: %i[edit update foreman_description]

  def show
    @experiences = @user.experiences.order(start_date_at: :desc)
    @foreman_description = @user.foreman_description || @user.build_foreman_description
    @editing = params[:edit] == "true" && current_user == @user # Enable edit mode if ?edit=true and user is authorized
  end

  def edit
  end

  def update
    if user_params[:password].present? || user_params[:password_confirmation].present?
      if @user.update(user_params)
        bypass_sign_in(@user)
        redirect_to profile_path(@user), notice: "Профиль был обновлен"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      if @user.update_without_password(user_params.except(:password, :password_confirmation))
        redirect_to profile_path(@user), notice: t("profile.update_success")
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def stats
    @user = User.find(params[:id])

    @tasks_data = {
      completed: @user.job_cards.where(status: "completed").count,
      in_progress: @user.job_cards.where(status: "in_progress").count,
      pending: @user.job_cards.where(status: "pending").count
    }

    render :stats
  end


  def job_cards
    @job_cards = @user.job_cards.order(created_at: :desc)
  end

  def foreman_description
    @foreman_description = @user.foreman_description || @user.build_foreman_description
    if request.post?
      if @foreman_description.update(foreman_description_params)
        redirect_to profile_path(@user), notice: t("foreman_description.update_success")
      else
        @experiences = @user.experiences.order(start_date_at: :desc)
        @editing = true
        render "show", status: :unprocessable_entity
      end
    end
  end

  def show_modal
    user = User.find(params[:id])

    respond_to do |f|
      f.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          :modal,
          renderable: ExperiencesModal.new(user)
        )
      }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :about,
      :phone,
      :birth_year,
      :city,
      :role,
      :password,
      :password_confirmation
    )
  end

  def foreman_description_params
    params.require(:foreman_description).permit(:farm_name, :description)
  end

  def authorize_user
    redirect_to root_path, alert: "Вы не авторизированы" unless current_user == @user
  end
end
