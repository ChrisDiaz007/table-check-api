class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  belongs_to :table

  enum status: { pending: "pending", confirmed: "confirmed", cancelled: "cancelled" }
end
