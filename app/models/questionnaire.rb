class Questionnaire < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :user_results, dependent: :destroy
  has_many :users, through: :user_results

  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :code, presence: true, uniqueness: true, format: { with: /\A[A-Z0-9]+\z/, message: "deve conter apenas letras maiúsculas e números" }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :duration_minutes, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 300 }
  validates :total_questions, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  scope :active, -> { where(active: true) }
  scope :by_user, ->(user) { where(user: user) }

  def average_score
    return 0 if user_results.empty?
    user_results.average(:score).round(2)
  end

  def total_attempts
    user_results.count
  end

  def completion_rate
    return 0 if total_attempts == 0
    (total_attempts.to_f / User.count * 100).round(2)
  end
end