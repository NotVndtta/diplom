class MediaFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_media_file, only: [ :show, :destroy ]

  def index
    @media_files = current_user.media_files.order(created_at: :desc)
    @media_file = MediaFile.new
    @job_cards = current_user.job_cards
  end

  def show
  end

  def new
    @media_file = current_user.media_files.build
  end

  def create
    @media_file = current_user.media_files.build(media_file_params)
    if @media_file.save

      redirect_to media_files_path, notice: "Медиафайл успешно загружен."
    else
      respond_to do |f|
        f.turbo_stream {
          render turbo_stream: turbo_stream.update(
            :modal,
            renderable: FileModal.new(@media_file)
          )
        }
      end
    end
  end

  def destroy
    @media_file.destroy
    redirect_to media_files_path, notice: "Медиафайл успешно удален."
  end

  def show_modal
    # @media_file = MediaFile.new
    media_file = current_user.media_files.build

    respond_to do |f|
      f.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          :modal,
          renderable: FileModal.new(media_file)
        )
      }
    end
  end

  def attach_to_job_card
    job_card = current_user.job_cards.find(params[:job_card_id])
    @job_card_media = job_card.job_card_media.build(media_file: @media_file)

    if @job_card_media.save
      redirect_to media_files_path, notice: "Медиафайл успешно привязан к агрооперации."
    else
      redirect_to media_files_path, alert: "Ошибка при привязке медиафайла."
    end
  end

  private

  def set_media_file
    @media_file = current_user.media_files.find(params[:id])
  end

  def media_file_params
    params.require(:media_file).permit(:file)
  end
end
