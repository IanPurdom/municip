class Question < ApplicationRecord
  belongs_to :questionnaire
  has_many :answers, dependent: :destroy
  has_one :user_program, dependent: :destroy
  has_many :indications, dependent: :destroy
  validates :question, presence: true, :length => { :minimum => 5 }
end
