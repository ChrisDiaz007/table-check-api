class ReservationSerializer
  include JSONAPI::Serializer
  attributes :id, :status, :table_id

  attribute :reservation_date do |reservation|
    reservation.reservation_time.strftime("%Y-%m-%d %A")
  end

  attribute :reservation_time do |reservation|
    reservation.reservation_time.strftime("%H:%M")
  end

  attribute :user do |reservation|
    user = reservation.user
      {
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        phone_number: user.phone_number
      }
  end

end
