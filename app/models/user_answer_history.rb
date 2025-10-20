class UserAnswerHistory < ApplicationRecord
  belongs_to :user_result
  belongs_to :question
  belongs_to :question_option

  validates :correct, inclusion: { in: [true, false] }

  scope :correct, -> { where(correct: true) }
  scope :incorrect, -> { where(correct: false) }

  def correct_answer
    question.correct_option
  end

  def user_answer
    question_option
  end

  def is_correct_answer?
    question_option == correct_answer
  end
end