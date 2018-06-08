class City < ApplicationRecord
  geocoded_by :name
  after_validation :geocode, if: :will_save_change_to_name?
  belongs_to :user
  has_many :interco_cities, dependent: :destroy
  has_many :intercommunalites, through: :interco_cities
  validates :name, presence: true
  validates :zip_code, presence: true
  validates :code_commune, presence: true
end
