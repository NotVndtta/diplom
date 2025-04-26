class JobApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job_card, only: [ :create, :index, :update ]

  def create
    @job_application = @job_card.job_applications.build(user: current_user, status: "pending")

    if @job_application.save
      redirect_to @job_card, notice: "Вы откликнулись на вакансию."
    else
      redirect_to @job_card, alert: "Невозможно откликнуться: #{@job_application.errors.full_messages.join(', ')}."
    end
  end

  def index
    if @job_card.user == current_user
      @job_applications = @job_card.job_applications.includes(:user).order(created_at: :desc)
    else
      redirect_to @job_card, alert: "Вы не авторизованы для просмотра откликов."
    end
  end

  def update
    @job_application = @job_card.job_applications.find(params[:id])
    if @job_card.user == current_user
      if @job_application.accepted? || job_application_params[:status] != "accepted"
        if @job_application.update(job_application_params)
          auto_reject_pending_if_limit_reached
          redirect_to job_card_job_applications_path(@job_card), notice: "Статус отклика обновлен."
        else
          redirect_to job_card_job_applications_path(@job_card), alert: "Невозможно обновить статус."
        end
      else
        accepted_count = @job_card.job_applications.accepted.count
        if accepted_count >= @job_card.work_amount
          redirect_to job_card_job_applications_path(@job_card), alert: "Нельзя принять больше рабочих, чем указано в work_amount (#{@job_card.work_amount})."
        elsif @job_application.update(job_application_params)
          auto_reject_pending_if_limit_reached
          redirect_to job_card_job_applications_path(@job_card), notice: "Статус отклика обновлен."
        else
          redirect_to job_card_job_applications_path(@job_card), alert: "Невозможно обновить статус."
        end
      end
    else
      redirect_to @job_card, alert: "Вы не авторизованы для обновления этого отклика."
    end
  end

  private

  def set_job_card
    @job_card = JobCard.find(params[:job_card_id])
  end

  def job_application_params
    params.require(:job_application).permit(:status)
  end

  def auto_reject_pending_if_limit_reached
    if @job_application.accepted? && @job_card.work_amount
      accepted_count = @job_card.job_applications.accepted.count
      if accepted_count >= @job_card.work_amount
        @job_card.job_applications.pending.update_all(status: "rejected")
      end
    end
  end
end
