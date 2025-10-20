class UserResultsController < ApplicationController
  before_action :set_user_result, only: [:show, :destroy]
  before_action :authorize_user_result, only: [:show, :destroy]

  def index
    @user_results = policy_scope(UserResult).includes(:questionnaire, :user).recent
    @user_results = @user_results.by_user(current_user) unless current_user.admin?
  end

  def show
    @answer_histories = @user_result.user_answer_histories.includes(:question, :question_option)
  end

  def destroy
    @user_result.destroy
    redirect_to user_results_url, notice: 'Resultado excluído com sucesso!'
  end

  private

  def set_user_result
    @user_result = UserResult.find(params[:id])
  end

  def authorize_user_result
    authorize @user_result
  end
end





