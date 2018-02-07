class Category < ApplicationRecord
  has_many :questionnaires
  has_many :programs
end
