class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update job_cards]
  before_action :authenticate_user!, only: %i[edit update]
  before_action :authorize_user, only: %i[edit update]

  def show
    @experiences = @user.experiences.order(start_date_at: :desc)
  end

  def edit
  end

  def update
    if user_params[:password].present? || user_params[:password_confirmation].present?
      if @user.update(user_params)
        bypass_sign_in(@user)
        redirect_to profile_path(@user), notice: t('profile.update_success')
      else
        render :edit, status: :unprocessable_entity
      end
    else
      if @user.update_without_password(user_params.except(:password, :password_confirmation))
        redirect_to profile_path(@user), notice: t('profile.update_success')
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def job_cards
    @job_cards = @user.job_cards.order(created_at: :desc)
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

  def authorize_user
    redirect_to root_path, alert: t('profile.unauthorized') unless current_user == @user
  end
end
