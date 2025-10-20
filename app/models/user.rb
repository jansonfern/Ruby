class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enums para roles (sintaxe compatível)
  enum :role, { student: 0, moderator: 1, admin: 2 }

  # Validações
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true

  # Relacionamentos
  has_many :user_results, dependent: :destroy
  has_many :questionnaires, through: :user_results
  has_many :created_questionnaires, class_name: 'Questionnaire', foreign_key: 'user_id', dependent: :destroy

  # Métodos de conveniência
  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def student?
    role == 'student'
  end

  def can_manage_quizzes?
    admin? || moderator?
  end

  def can_view_all_results?
    admin?
  end
end