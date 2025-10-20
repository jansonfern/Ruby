class QuestionnairesController < ApplicationController
  before_action :set_questionnaire, only: [:show, :edit, :update, :destroy, :take, :submit, :results]
  before_action :authorize_questionnaire, only: [:show, :edit, :update, :destroy, :results]

  def index
    @questionnaires = policy_scope(Questionnaire).includes(:user).active
  end

  def show
    @questions = @questionnaire.questions.includes(:question_options).ordered
  end

  def new
    @questionnaire = current_user.questionnaires.build
    authorize @questionnaire
  end

  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    @questionnaire.user = current_user
    authorize @questionnaire

    if @questionnaire.save
      redirect_to @questionnaire, notice: 'Questionário criado com sucesso!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @questionnaire.update(questionnaire_params)
      redirect_to @questionnaire, notice: 'Questionário atualizado com sucesso!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @questionnaire.destroy
    redirect_to questionnaires_url, notice: 'Questionário excluído com sucesso!'
  end

  def take
    authorize @questionnaire, :take_quiz?
    @questions = @questionnaire.questions.includes(:question_options).ordered
  end

  def submit
    authorize @questionnaire, :submit_quiz?
    
    # Processar respostas e calcular resultado
    result = process_quiz_submission
    
    if result[:success]
      redirect_to results_questionnaire_path(@questionnaire), notice: 'Quiz enviado com sucesso!'
    else
      flash[:alert] = result[:error]
      redirect_to take_questionnaire_path(@questionnaire)
    end
  end

  def results
    @user_result = current_user.user_results.find_by(questionnaire: @questionnaire)
    @answer_histories = @user_result&.user_answer_histories&.includes(:question, :question_option) || []
    
    # Se não há resultado, redirecionar para o quiz
    unless @user_result
      redirect_to take_questionnaire_path(@questionnaire), alert: 'Você ainda não respondeu este quiz.'
      return
    end
    
    # Autorizar apenas se há resultado
    authorize @questionnaire, :results?
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  def authorize_questionnaire
    authorize @questionnaire
  end

  def questionnaire_params
    params.require(:questionnaire).permit(:title, :code, :description, :duration_minutes, :total_questions, :active)
  end

  def process_quiz_submission
    answers = params[:answers] || {}
    questions = @questionnaire.questions.includes(:question_options).ordered
    
    # Calcular score
    correct_count = 0
    total_questions = questions.count
    
    answer_histories = []
    
    questions.each do |question|
      selected_option_id = answers[question.id.to_s]&.to_i
      selected_option = question.question_options.find_by(id: selected_option_id)
      correct_option = question.question_options.find(&:correct?)
      
      is_correct = selected_option && correct_option && selected_option.id == correct_option.id
      correct_count += 1 if is_correct
      
      answer_histories << {
        question: question,
        question_option: selected_option || question.question_options.first,
        correct: is_correct
      }
    end
    
    score = total_questions > 0 ? ((correct_count.to_f / total_questions) * 100).round : 0
    grade = calculate_grade(score)
    
    # Criar ou atualizar resultado do usuário
    user_result = current_user.user_results.find_or_initialize_by(questionnaire: @questionnaire)
    user_result.assign_attributes(
      score: score,
      grade: grade,
      submitted_at: Time.current
    )
    
    if user_result.save
      # Criar histórico de respostas
      user_result.user_answer_histories.destroy_all
      answer_histories.each do |history|
        user_result.user_answer_histories.create!(
          question: history[:question],
          question_option: history[:question_option],
          correct: history[:correct]
        )
      end
      
      # Enviar email com os resultados
      QuizMailer.quiz_completed(current_user, @questionnaire, user_result).deliver_later
      
      { success: true }
    else
      { success: false, error: 'Erro ao salvar resultado do quiz.' }
    end
  end

  def calculate_grade(score)
    case score
    when 90..100 then 'A'
    when 80..89  then 'B'
    when 60..79  then 'C'
    when 40..59  then 'D'
    else 'F'
    end
  end
end