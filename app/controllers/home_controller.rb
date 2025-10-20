class HomeController < ApplicationController
  def index
    # Get questionnaires that user can access
    @questionnaires = policy_scope(Questionnaire).active.includes(:user).limit(6)
    
    # Get user's recent results
    if user_signed_in?
      @user_results = current_user.user_results.includes(:questionnaire).recent.limit(5)
    else
      @user_results = []
    end

    # Statistics for admin users
    if user_signed_in? && current_user.admin?
      @total_questionnaires = Questionnaire.count
      @total_questions = Question.count
      @total_users = User.count
      @total_attempts = UserResult.count
    end

    # Removido: criação/exibição de admin de teste na home
  end
end
