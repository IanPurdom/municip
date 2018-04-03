class City < ApplicationRecord
  geocoded_by :name
  after_validation :geocode, if: :will_save_change_to_name?
  belongs_to :user
  validates :name, presence: true
  validates :zip_code, presence: true
end
