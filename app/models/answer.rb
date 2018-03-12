class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :status
  belongs_to :question
  # belongs_to :next_question, class_name: 'Question', foreign_key: 'next_question_id'
  has_many :program_to_answers, dependent: :destroy
end
