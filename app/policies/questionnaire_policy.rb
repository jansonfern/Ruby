class QuestionnairePolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user&.can_manage_quizzes?
  end

  def update?
    user&.can_manage_quizzes? && (user.admin? || record.user == user)
  end

  def destroy?
    user&.admin? || (user&.can_manage_quizzes? && record.user == user)
  end

  def take_quiz?
    user.present? && record.active?
  end

  def submit_quiz?
    user.present? && record.active?
  end

  def results?
    user.present? && (user.admin? || record.user == user || user.user_results.exists?(questionnaire: record))
  end

  class Scope < Scope
    def resolve
      if user&.admin?
        scope.all
      elsif user&.can_manage_quizzes?
        scope.where(user: user)
      else
        scope.active
      end
    end
  end
end





