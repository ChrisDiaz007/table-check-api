class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  belongs_to :table, optional: true

  enum status: { pending: "pending", accepted: "accepted", rejected: "rejected" ,cancelled: "cancelled" }

  validates :party_size, numericality: { only_integer: true, greater_than: 0}
  validates :reservation_time, :party_size, presence: true

  # Block any second reservation at the same exact time for this restaurant
  validates :reservation_time, uniqueness: {
    scope: :restaurant_id,
    message: "slot is already taken for this restaurant"
  }

end
