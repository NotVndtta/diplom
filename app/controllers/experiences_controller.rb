class ExperiencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_experience, only: %i[ show edit update destroy ]

  def index
    @profile = User.find(params[:profile_id])
    @experiences = @profile.experiences

  end

  def new
    @profile = User.find(params[:profile_id])
    @experience = Experience.new
  end

  def edit
    
  end

  def create
      @profile = User.find(params[:profile_id])
      @experience = @profile.experiences.build(experience_params)
      if @experience.save
        redirect_to profile_path(@profile), notice: "Experience created successfully."
      else
        @user = @profile
        @experiences = @profile.experiences
        render "profiles/show", status: :unprocessable_entity
      end
  end

  def update
    respond_to do |format|
      if @experience.update(experience_params)
        format.html { redirect_to @experience, notice: "Experience was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @experience.destroy!

    respond_to do |format|
      format.html { redirect_to profile_experience_path(@profile, @experience), status: :see_other, notice: "Experience was successfully destroyed." }
    end
  end

  private
    def set_experience
      @experience = Experience.find(params[:id])
    end

    def experience_params
      params.require(:experience).permit(:start_date_at, :end_date_at, :description, :company)
    end
end
