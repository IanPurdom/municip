class Interview < ApplicationRecord
  belongs_to :user
  belongs_to :questionnaire
  has_many :questions, through: :questionnaires, source: :question
  has_many :answers_to_questions, through: :questions
  has_many :user_programs
  validates :questionnaire, uniqueness: { scope: :user }
end
