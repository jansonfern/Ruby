class QuestionOption < ApplicationRecord
  belongs_to :question
  has_many :user_answer_histories, dependent: :destroy

  validates :title, presence: true, length: { minimum: 1, maximum: 500 }
  validates :position, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(:position) }
  scope :correct, -> { where(correct: true) }

  def correct?
    correct
  end
end