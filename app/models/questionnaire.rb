class Questionnaire < ApplicationRecord
  belongs_to :category
  has_many :interviews
  has_many :questions, dependent: :destroy
  validates :category, presence: true
  # validates :order, presence: true
end
