class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :photo, PhotoUploader
  has_many :deputies, dependent: :destroy
  has_many :cities, dependent: :destroy
  has_many :photos, through: :cities
  has_many :interviews
  has_many :user_programs, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
