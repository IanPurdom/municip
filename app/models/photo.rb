class Photo < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :city
  validates :photo, presence: true
  validates :city_id, presence: true
end
