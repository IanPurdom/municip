class CityAccount < ApplicationRecord
  validates :code_commune, presence: true
end
