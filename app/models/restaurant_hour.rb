class RestaurantHour < ApplicationRecord
  belongs_to :restaurant

  validates :day_of_week, presence: true
  validates :opens_at, presence: true
  validates :closes_at, presence: true
end
