class Answer < ApplicationRecord
  has_many :answers_to_questions
  has_many :questions, through: :answers_to_questions
  has_many :program_to_answers, through: :answers_to_questions
end
