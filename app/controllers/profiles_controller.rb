class ProfilesController < ApplicationController
  before_action :set_user
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
    @stats = StatisticsService.new(@user)

    respond_to do |format|
      format.html
      format.json do
        stats_data = {
          job_cards: @stats.job_cards_stats,
          ratings: @stats.ratings_distribution,
          monthly_jobs: @stats.monthly_jobs_stats,
          average_ratings: @stats.average_rating_by_month,
          top_locations: @stats.top_locations,
          earnings: @stats.earnings_by_month,
          applications: @stats.job_applications_stats,
          work_amounts: @stats.work_amount_distribution
        }
        Rails.logger.info "Stats data: #{stats_data.inspect}"
        render json: stats_data
      end
    end
  end


  def job_cards
    @q = @user.job_cards.ransack(params[:q])
    @job_cards = @q.result.order(created_at: :desc)
    @view = params[:view] == "table" ? "table" : "card"
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


  def responses
    @responses = @user.job_applications
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
      :password_confirmation,
      :avatar
    )
  end

  def foreman_description_params
    params.require(:foreman_description).permit(:farm_name, :description)
  end

  def authorize_user
    redirect_to root_path, alert: "Вы не авторизированы" unless current_user == @user
  end
end
