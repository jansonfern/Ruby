class QuestionOptionsController < ApplicationController
  before_action :set_question_option, only: [:show, :edit, :update, :destroy]
  before_action :set_question
  before_action :set_questionnaire
  before_action :authorize_question_option, only: [:show, :edit, :update, :destroy]

  def index
    @question_options = @question.question_options.ordered
    authorize @question, :show?
  end

  def show
  end

  def new
    @question_option = @question.question_options.build
    authorize @question_option
  end

  def create
    @question_option = @question.question_options.build(question_option_params)
    authorize @question_option

    if @question_option.save
      redirect_to question_question_options_path(@question), notice: 'Opção criada com sucesso!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @question_option.update(question_option_params)
      redirect_to question_question_options_path(@question), notice: 'Opção atualizada com sucesso!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question_option.destroy
    redirect_to question_question_options_path(@question), notice: 'Opção excluída com sucesso!'
  end

  private

  def set_question_option
    @question_option = QuestionOption.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_questionnaire
    @questionnaire = @question.questionnaire
  end

  def authorize_question_option
    authorize @question_option
  end

  def question_option_params
    params.require(:question_option).permit(:title, :correct, :position)
  end
end