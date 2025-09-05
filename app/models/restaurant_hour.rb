class RestaurantHour < ApplicationRecord
  belongs_to :restaurant

  validates :opens_at, presence: true
  validates :closes_at, presence: true
  validates :day_of_week, presence: true, inclusion: { in: 0..6 }
  validates :day_of_week, uniqueness: { scope: :restaurant_id }
end
