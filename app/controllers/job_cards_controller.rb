class JobCardsController < ApplicationController
  before_action :set_job_card, only: %i[ show edit update destroy ]

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
  end

  def edit
  end

  def create
    @job_card = JobCard.new(job_card_params)
    @job_card.user = current_user

    respond_to do |format|
      if @job_card.save
        format.html { redirect_to @job_card, notice: "Job card was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_card.update(job_card_params)
        format.html { redirect_to @job_card, notice: "Job card was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_card.destroy!

    respond_to do |format|
      format.html { redirect_to job_cards_path, status: :see_other, notice: "Job card was successfully destroyed." }
    end
  end

  private

  def set_job_card
    @job_card = JobCard.find(params[:id])
  end

  def job_card_params
    params.require(:job_card).permit(:farm_name, :remuneration, :work_amount, :description, :date_at, :location, :status, :count_users, :user_id)
  end
end
