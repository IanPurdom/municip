class Intercommunalite < ApplicationRecord
  has_many :cities
  validates :epci_number, presence: true
end
