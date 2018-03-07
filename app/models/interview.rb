class Interview < ApplicationRecord
  belongs_to :status
  belongs_to :user
  belongs_to :questionnaire
  belongs_to :category
  has_many :questions, through: :questionnaires, source: :question
  has_many :answers, through: :questions
  has_many :user_programs
  validates :questionnaire, uniqueness: { scope: :user }
end
