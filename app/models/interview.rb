class Interview < ApplicationRecord
  belongs_to :user
  belongs_to :questionnaire
  has_many :questions, through: :questionnaires, source: :question
  validates :questionnaire, uniqueness: { scope: :user }
end
