class Category < ApplicationRecord
  has_many :questionnaires
  has_many :programs
  has_many :user_programs
end
