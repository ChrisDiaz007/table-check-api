class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :reservations, dependent: :nullify

  validates :number, uniqueness: { scope: :restaurant_id }
  validates :number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :seats, presence: :true, numericality: { only_integer: true, greater_than: 0 }
end
