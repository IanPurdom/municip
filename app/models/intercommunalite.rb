class Intercommunalite < ApplicationRecord
  has_many :interco_cities, dependent: :destroy
  has_many :cities, through: :interco_cities
  validates :epci_number, presence: true
end
