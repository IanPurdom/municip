class UserProgram < ApplicationRecord
  belongs_to :user
  belongs_to :interview
  belongs_to :question
  belongs_to :category
  validates :interview, uniqueness: {:scope => [:user, :question]}
end
