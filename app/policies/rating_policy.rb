class RatingPolicy < ApplicationPolicy
  def create?
    user.present? && record.rateable != user
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  def update?
    false # Отзывы нельзя редактировать
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
