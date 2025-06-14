class JobCardsController < ApplicationController
  before_action :set_job_card, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @q = JobCard.ransack(params[:q])
    @job_cards = @q.result
                   .where.not(farm_name: nil)
    @view = params[:view] == "table" ? "table" : "card"
  end

  def show
  end

  def new
    @job_card = JobCard.new
    authorize @job_card
  end

  def edit
    authorize @job_card
  end

  def create
    @job_card = JobCard.new(job_card_params)
    @job_card.user = current_user
    authorize @job_card

    respond_to do |format|
      if @job_card.save
        format.html { redirect_to @job_card, notice: "Агрооперация успешно создана." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @job_card
    respond_to do |format|
      if @job_card.update(job_card_params)
        format.html { redirect_to @job_card, notice: "Агрооперация успешно обновлена." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @job_card
    @job_card.destroy!

    respond_to do |format|
      format.html { redirect_to job_cards_path, status: :see_other, notice: "Агрооперация успешно удалена." }
    end
  end

  private

  def set_job_card
    @job_card = JobCard.find(params[:id])
  end

  def job_card_params
    params.require(:job_card).permit(:farm_name, :remuneration, :work_amount, :description, :date_at, :location, :status, :count_users)
  end
end
