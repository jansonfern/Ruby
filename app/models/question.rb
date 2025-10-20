class Question < ApplicationRecord
  belongs_to :questionnaire
  has_many :question_options, dependent: :destroy
  has_many :user_answer_histories, dependent: :destroy

  validates :enunciation, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :position, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(:position) }

  def correct_option
    question_options.find(&:correct?)
  end

  def correct_option_id
    correct_option&.id
  end

  def options_count
    question_options.count
  end

  def has_correct_option?
    question_options.exists?(correct: true)
  end
end