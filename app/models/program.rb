class Program < ApplicationRecord
  belongs_to :category
  belongs_to :answer
  validates :category, presence: true
  validates :content, presence: true
end
