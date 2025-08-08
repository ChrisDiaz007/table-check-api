class RestaurantPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none unless user
      user.admin? ? scope.all : scope.where(user: user)
    end
  end

  def index?
    return true
  end

  def show?
    return true
  end

  def new?
    return create?
  end

  def create?
    return admin? || (user.present? && user.owner?)
  end

  def edit?
    return update?
  end

  def update?
    return admin? || record.user == user
  end

  def destroy?
    return admin? || record.user == user
  end

  def upload_photo?
    return true
  end

end
