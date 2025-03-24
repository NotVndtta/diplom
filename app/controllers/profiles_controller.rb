class ProfilesController < ApplicationController
  before_action :set_user, only: %i[ show edit ]

  def index
  end

  def show
  end

  def edit
  end

  private
    def set_user
      @user = User.find(params.expect(:id))
      @experiences = @user.experiences
    end

    def user_params
      params.expect(profile: [ :user_id ])
    end
end
