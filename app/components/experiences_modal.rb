class ExperiencesModal < ViewComponent::Base
  def initialize(user, experience)
    @user = user
    @experience =experience
  end
end
