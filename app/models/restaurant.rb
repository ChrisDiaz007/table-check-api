class Restaurant < ApplicationRecord
  has_one_attached :photo, dependent: :purge_later

  belongs_to :user

  # Tables
  has_many :tables, dependent: :destroy

  # Reservations
  has_many :reservations, dependent: :destroy

  # Hours
  has_many :restaurant_hours, dependent: :destroy

  # Followers
  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :user

  # Fans - users who favorite this restaurant
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  # Cuisine
  has_many :cuisines_restaurants, dependent: :destroy
  has_many :cuisines, through: :cuisines_restaurants

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, presence: true
  validates :address, presence: true
  validates :photo, presence: true
  # validates :restaurant_id, uniqueness: { scope: :cuisine_id }
end
