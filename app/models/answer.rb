class Answer < ApplicationRecord
  belongs_to :question
  has_many :program_to_answers, dependent: :destroy
end
