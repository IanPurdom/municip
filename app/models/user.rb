class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :photo, PhotoUploader
  has_many :deputies, dependent: :destroy
  has_many :cities, dependent: :destroy
  has_many :photos, through: :cities
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
