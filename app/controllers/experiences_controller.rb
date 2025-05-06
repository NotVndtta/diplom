class ExperiencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_experience, only: %i[new edit update destroy]

  def new
    @experience = Experience.new
  end

  def edit
  end

  def create
    @profile = User.find(params[:profile_id])
    @experience = Experience.new(experience_params)
    @experience.user = @profile

    if @experience.valid?
      @experience.save!
      redirect_to profile_path(@profile), notice: "Experience created successfully."
    else
      respond_to do |f|
        f.turbo_stream {
          render turbo_stream: turbo_stream.update(
            :modal,
            renderable: ExperiencesModal.new(@profile, @experience)
          )
        }
      end
    end
  end

  def update
    respond_to do |format|
      if @experience.update(experience_params)
        format.html { redirect_to @profile, notice: "Experience was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @experience.destroy!

    respond_to do |format|
      format.html {
        redirect_to profile_path(@profile), notice: "Experience was successfully destroyed."
      }
    end
  end

  def show_modal
    @experience = Experience.new
    @user = User.find(params[:profile_id])

    respond_to do |f|
      f.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          :modal,
          renderable: ExperiencesModal.new(@user,  @experience)
        )
      }
    end
  end

  private

  def set_experience
    @profile = User.find(params[:profile_id])
    @experience = @profile.experiences.find(params[:id])
  end

  def experience_params
    params.require(:experience).permit(:start_date_at, :end_date_at, :description, :company)
  end
end
