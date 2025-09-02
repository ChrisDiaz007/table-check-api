class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  belongs_to :table

  enum status: { pending: "pending", accepted: "accepted", rejected: "rejected" ,cancelled: "cancelled" }

  validates :reservation_time, :party_size, presence: :true
  validates :party_size, numericality: { only_integer: true, greater_than: 0}

  validate :starts_on_half_hour
  # validate :start_on_the_hour

  validate :no_overlap_on_table

  before_validation :ensure_pending

  private

  def ensure_pending
    self.status ||= "pending"
  end

  # Only allow reservation times at :00 or :30
  def starts_on_half_hour
    return if reservation_time.blank?
    unless [0, 30].include?(reservation_time.min)
      errors.add(:reservation_time, "must be on the half-hour (e.g., 18:00, 18:30, 19:00)")
    end
  end

  # def starts_on_the_hour
  #   return if reservation_time.blank?
  #   errors.add(:reservation_time, "must be on the hour (e.g., 19:00, 20:00)") unless reservation_time.min.zero?
  # end

  # Prevent overlapping reservations within 30 minutes
  def no_overlap_on_table
    return if reservation_time.blank? || table_id.blank?

    window_start = reservation_time - 29.minutes
    window_end   = reservation_time + 29.minutes

    conflict = Reservation
      .where(table_id: table_id)
      .where.not(id: id)
      .where(reservation_time: window_start..window_end)
      .exists?

    errors.add(:reservation_time, "conflicts with another reservation for this table within an hour") if conflict
  end

end
