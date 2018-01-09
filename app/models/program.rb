class Program < ApplicationRecord
  belongs_to :category
  validates :title, presence: true
  validates :category, presence: true
  validates :content, presence: true
end
