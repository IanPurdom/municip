class City < ApplicationRecord
  mount_uploader :photo_1, PhotoUploader
  mount_uploader :photo_2, PhotoUploader
  mount_uploader :photo_3, PhotoUploader
  belongs_to :user
  validates :name, presence: true
  validates :zip_code, presence: true, uniqueness: true
end
