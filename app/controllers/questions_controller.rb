class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_questionnaire
  before_action :authorize_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = @questionnaire.questions.includes(:question_options).ordered
    authorize @questionnaire, :show?
  end

  def show
  end

  def new
    @question = @questionnaire.questions.build
    authorize @question
  end

  def create
    @question = @questionnaire.questions.build(question_params)
    authorize @question

    if @question.save
      redirect_to questionnaire_questions_path(@questionnaire), notice: 'Pergunta criada com sucesso!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to questionnaire_questions_path(@questionnaire), notice: 'Pergunta atualizada com sucesso!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    redirect_to questionnaire_questions_path(@questionnaire), notice: 'Pergunta excluída com sucesso!'
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
  end

  def authorize_question
    authorize @question
  end

  def question_params
    params.require(:question).permit(:enunciation, :position)
  end
end