class Restaurant < ApplicationRecord

  # Tables
  has_many :tables, dependent: :destroy

  # Reservations
  has_many :reservations, dependent: :destroy

  # Hours
  has_many :restaurant_hours, dependent: :destroy

  # Followers
  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :user

  # Fans (users who favorited this restaurant)
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

end
