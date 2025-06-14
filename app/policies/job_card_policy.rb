class JobCardPolicy < ApplicationPolicy
  def index?
    true # Все могут просматривать список агроопераций
  end

  def show?
    true # Все могут просматривать детали агрооперации
  end

  def create?
    user.present? && user.foreman? # Только прорабы могут создавать агрооперации
  end

  def update?
    user.present? && (record.user == user || user.admin?) # Только автор или админ могут редактировать
  end

  def destroy?
    user.present? && (record.user == user || user.admin?) # Только автор или админ могут удалять
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
