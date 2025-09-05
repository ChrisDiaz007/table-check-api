class RestaurantHourSerializer
  include JSONAPI::Serializer
  attributes :id, :day_of_week

  attribute :user_id do |restaurant_hour|
    restaurant_hour.restaurant.user_id
  end

  attribute :restaurant_id do |restaurant_hour|
    restaurant_hour.restaurant_id
  end

  attribute :opens_at do |restaurant_hour|
    restaurant_hour.opens_at.strftime("%H:%M")
  end

  attribute :closes_at do |restaurant_hour|
    restaurant_hour.closes_at.strftime("%H:%M")
  end

end
