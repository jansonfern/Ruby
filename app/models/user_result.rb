class UserResult < ApplicationRecord
  belongs_to :user
  belongs_to :questionnaire
  has_many :user_answer_histories, dependent: :destroy

  validates :score, presence: true, numericality: { in: 0..100 }
  validates :grade, presence: true, inclusion: { in: %w[A B C D F] }
  validates :submitted_at, presence: true

  scope :by_user, ->(user) { where(user: user) }
  scope :by_questionnaire, ->(questionnaire) { where(questionnaire: questionnaire) }
  scope :recent, -> { order(submitted_at: :desc) }

  def calculate_grade!
    self.grade = case score
                 when 90..100 then 'A'
                 when 80..89  then 'B'
                 when 60..79  then 'C'
                 when 40..59  then 'D'
                 else 'F'
                 end
  end

  def passed?
    score >= 60
  end

  def excellent?
    score >= 90
  end

  def correct_answers_count
    user_answer_histories.where(correct: true).count
  end

  def total_questions_count
    questionnaire.questions.count
  end

  def accuracy_percentage
    return 0 if total_questions_count == 0
    (correct_answers_count.to_f / total_questions_count * 100).round(2)
  end
end