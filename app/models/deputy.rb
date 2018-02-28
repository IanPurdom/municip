class Deputy < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  belongs_to :category
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :title, presence: true
end
