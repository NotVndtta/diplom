# app/controllers/ratings_controller.rb
class RatingsController < ApplicationRecord
  before_action :authenticate_user!
  before_action :set_rating, only: [:destroy]
  before_action :authorize_user!, only: [:destroy]

  def create
    @rateable = find_rateable
    @rating = @rateable.ratings.build(rating_params)
    @rating.user = current_user

    if @rating.save
      redirect_to @rateable, notice: "Отзыв успешно добавлен."
    else
      flash[:alert] = "Не удалось добавить отзыв."
      render "new"
    end
  end

  def destroy
    @rateable = @rating.rateable
    @rating.destroy
    redirect_to @rateable, notice: "Отзыв успешно удален."
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
end
