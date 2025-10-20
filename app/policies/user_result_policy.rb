class UserResultPolicy < ApplicationPolicy
  def index?
    user&.can_view_all_results?
  end

  def show?
    user.present? && (user.admin? || record.user == user)
  end

  def create?
    user.present?
  end

  def update?
    false # User results should not be updated after creation
  end

  def destroy?
    user&.admin?
  end

  class Scope < Scope
    def resolve
      if user&.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end





