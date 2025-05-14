class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rating, only: [ :destroy ]
  before_action :authorize_user!, only: [ :destroy ]

  def index
    @rateable = find_rateable
    @ratings = @rateable.ratings.includes(:user).order(created_at: :desc).page(params[:page]).per(5)

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def create
    @rateable = find_rateable
    @rating = @rateable.ratings.build(rating_params)
    @rating.user = current_user

    respond_to do |format|
      if @rating.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("rating_form", partial: "ratings/form", locals: { rateable: @rateable }),
            turbo_stream.update("ratings_list", partial: "ratings/ratings_list", locals: { rateable: @rateable }),
            turbo_stream.prepend("flash", partial: "shared/flash", locals: { notice: "Отзыв успешно добавлен" })
          ]
        end
        format.html { redirect_to @rateable, notice: "Отзыв успешно добавлен." }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("rating_form", partial: "ratings/form", locals: { rateable: @rateable }),
            turbo_stream.prepend("flash", partial: "shared/flash", locals: { alert: "Пожалуйста, исправьте ошибки в форме" })
          ]
        end
        format.html { render :new }
      end
    end
  end

  def destroy
    @rateable = @rating.rateable
    @rating.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("ratings_list", partial: "ratings/ratings_list", locals: { rateable: @rateable }),
          turbo_stream.prepend("flash", partial: "shared/flash", locals: { notice: "Отзыв успешно удален" })
        ]
      end
      format.html { redirect_to @rateable, notice: "Отзыв успешно удален." }
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:comment, :grade)
  end

  def find_rateable
    if params[:job_card_id]
      JobCard.find(params[:job_card_id])
    elsif params[:profile_id]
      User.find(params[:profile_id])
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def set_rating
    @rating = Rating.find(params[:id])
  end

  def authorize_user!
    unless @rating.user == current_user || current_user.admin?
      redirect_to @rating.rateable, alert: "Вы не можете удалить этот отзыв."
    end
  end

  def rating_reviews_path
    case @rateable
    when User
      profile_ratings_path(@rateable.user)
    when JobCard
      job_card_path(@rateable)
    else
      raise "Unknown rateable type: #{@rateable.class}"
    end
  end
end
