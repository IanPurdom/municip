class Indication < ApplicationRecord
  belongs_to :question
  validates :indication, presence: true
end
