class QuestionPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.present? && (user.admin? || user.moderator? || user == record.questionnaire.user)
  end

  def update?
    user.present? && (user.admin? || user.moderator? || user == record.questionnaire.user)
  end

  def destroy?
    user.present? && (user.admin? || user.moderator? || user == record.questionnaire.user)
  end

  class Scope < Scope
    def resolve
      if user&.admin?
        scope.all
      elsif user&.moderator?
        scope.all
      else
        scope.joins(:questionnaire).where(questionnaires: { user: user })
      end
    end
  end
end
