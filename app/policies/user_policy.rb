class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    return user.admin? || record == user
  end

  def restaurants?
    return true
  end

  def update?
    return record == user
  end
end
