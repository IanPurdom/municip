class Question < ApplicationRecord
  belongs_to :questionnaire
  has_many :answers_to_questions, dependent: :destroy
  has_many :answers, through: :answers_to_questions, dependent: :destroy
end
