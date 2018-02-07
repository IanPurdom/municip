class AnswersToQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :answer
  has_many :program_to_answers, dependent: :destroy
end
