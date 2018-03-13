class Program < ApplicationRecord
  belongs_to :category
  has_many :program_to_answers, dependent: :destroy
  has_many :answers, through: :program_to_answers
  validates :category, presence: true
  validates :content, presence: true
end
