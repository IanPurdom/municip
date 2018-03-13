class Question < ApplicationRecord
  belongs_to :questionnaire
  has_many :answers, dependent: :destroy
  has_one :user_program, dependent: :destroy
end
