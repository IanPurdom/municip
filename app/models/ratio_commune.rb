class RatioCommune < ApplicationRecord
  validates :ratio, presence: true
  validates :name, presence: true, uniqueness: {scope: :strate}
  validates :description, presence: true
  validates :strate, presence: true
end
