class Photo < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  validates :photo, presence: true
end
