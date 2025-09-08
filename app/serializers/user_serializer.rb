class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :first_name, :last_name, :phone_number, :role, :admin, :email

  attribute :bookings do |user|
    user.reservations.map do |reservation|
      {
        id: reservation.id,
        user_id: reservation.user_id,
        restaurant_id: reservation.restaurant_id,
        restaurant_name: reservation.restaurant.name,
        reservation_time: reservation.reservation_time&.strftime("%H:%M"),
        reservation_date: reservation.reservation_time&.strftime("%Y-%m-%d %A"),
        status: reservation.status,
        restaurant_photo: reservation.restaurant&.photo.url
      }
    end
  end

  attribute :restaurants do |user|
    user.restaurants.map do |restaurant|
      {
        id: restaurant.id,
        restaurant_name: restaurant.name,

        reservations: restaurant.reservations.map do |reservation|
          {
            id: reservation.id
          }
        end
      }
    end
  end

  attribute :created_date do |user|
    user.created_at && user.created_at.strftime('%m/%d/%Y')
  end
end
