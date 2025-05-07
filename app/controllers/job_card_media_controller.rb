class JobCardMediaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job_card

  def new
    @job_card_media = @job_card.job_card_media.build
    @media_files = current_user.media_files
  end

  def create
    @job_card_media = @job_card.job_card_media.build(job_card_media_params)
    if @job_card_media.save
      redirect_to @job_card, notice: "Медиафайл успешно связан."
    else
      @media_files = current_user.media_files
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @job_card_media = @job_card.job_card_media.find(params[:id])
    @job_card_media.destroy
    redirect_to @job_card, notice: "Связь с медиафайлом удалена."
  end

  private

  def set_job_card
    @job_card = current_user.job_cards.find(params[:job_card_id])
  end

  def job_card_media_params
    params.require(:job_card_media).permit(:media_file_id, :description)
  end
end
