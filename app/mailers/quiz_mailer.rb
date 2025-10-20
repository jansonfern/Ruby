class QuizMailer < ApplicationMailer
  def quiz_completed(user, questionnaire, user_result)
    @user = user
    @questionnaire = questionnaire
    @user_result = user_result
    @answer_histories = user_result.user_answer_histories.includes(:question, :question_option)

    mail(
      to: @user.email,
      subject: "Quiz Concluído: #{@questionnaire.title}"
    )
  end

  def quiz_created(questionnaire)
    @questionnaire = questionnaire
    @creator = questionnaire.user

    # Enviar para todos os usuários cadastrados (ajuste: não há coluna 'active')
    User.find_each do |user|
      mail(
        to: user.email,
        subject: "Novo Quiz Disponível: #{@questionnaire.title}"
      )
    end
  end

  def quiz_results_summary(questionnaire, results_summary)
    @questionnaire = questionnaire
    @results_summary = results_summary
    @creator = questionnaire.user

    mail(
      to: @creator.email,
      subject: "Resumo dos Resultados: #{@questionnaire.title}"
    )
  end
end



