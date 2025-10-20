require 'ostruct'

class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def dashboard
    # Mock data para demonstração
    @total_users = 25
    @total_questionnaires = 4
    @total_questions = 20
    @total_results = 15
    
    # Mock recent results
    @recent_results = [
      OpenStruct.new(
        user: OpenStruct.new(name: "João Silva", email: "joao@example.com"),
        questionnaire: OpenStruct.new(title: "Quiz de Ruby on Rails"),
        score: 85,
        grade: "B",
        submitted_at: 2.hours.ago
      ),
      OpenStruct.new(
        user: OpenStruct.new(name: "Maria Santos", email: "maria@example.com"),
        questionnaire: OpenStruct.new(title: "Quiz de JavaScript"),
        score: 92,
        grade: "A",
        submitted_at: 4.hours.ago
      ),
      OpenStruct.new(
        user: OpenStruct.new(name: "Pedro Costa", email: "pedro@example.com"),
        questionnaire: OpenStruct.new(title: "Quiz de Python"),
        score: 78,
        grade: "C",
        submitted_at: 6.hours.ago
      )
    ]
  end

  def users
    @users = User.order(created_at: :desc)
  end

  def questionnaires
    @questionnaires = Questionnaire.includes(:questions).order(created_at: :desc)
  end


  def destroy_user
    @user = User.find(params[:id])
    
    # Prevent admin from deleting themselves
    if @user == current_user
      respond_to do |format|
        format.html { redirect_to admin_users_path, alert: 'Você não pode excluir sua própria conta.' }
        format.json { render json: { error: 'Você não pode excluir sua própria conta.' }, status: :unprocessable_entity }
      end
      return
    end
    
    # Prevent deleting the last admin
    if @user.admin? && User.where(role: :admin).count <= 1
      respond_to do |format|
        format.html { redirect_to admin_users_path, alert: 'Não é possível excluir o último administrador do sistema.' }
        format.json { render json: { error: 'Não é possível excluir o último administrador do sistema.' }, status: :unprocessable_entity }
      end
      return
    end
    
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_path, notice: 'Usuário excluído com sucesso.' }
        format.json { render json: { message: 'Usuário excluído com sucesso.' }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to admin_users_path, alert: 'Erro ao excluir usuário.' }
        format.json { render json: { error: 'Erro ao excluir usuário.' }, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to admin_users_path, alert: 'Usuário não encontrado.' }
      format.json { render json: { error: 'Usuário não encontrado.' }, status: :not_found }
    end
  end

  private

  def ensure_admin
    unless current_user.admin?
      redirect_to(user_signed_in? ? authenticated_root_path : unauthenticated_root_path,
                  alert: 'Acesso negado! Você precisa ser um administrador para acessar esta área.')
    end
  end
end
