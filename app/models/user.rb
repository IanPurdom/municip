class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_validation :set_role
  mount_uploader :photo, PhotoUploader
  belongs_to :role
  has_many :deputies, dependent: :destroy
  has_many :cities, dependent: :destroy
  has_many :photos, through: :cities
  has_many :interviews
  has_many :user_programs, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def set_role
    self.role = Role.find_by(role:"user")
  end
end
