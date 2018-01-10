class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :photo, PhotoUploader
  has_many :deputies
  has_many :cities
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
