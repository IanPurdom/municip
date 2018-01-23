class City < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  validates :name, presence: true
  validates :zip_code, presence: true
end
