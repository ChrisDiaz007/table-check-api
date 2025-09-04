class RestaurantSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :address, :prefecture, :district,
             :description, :phone_number, :website,
             :total_tables, :followers_count, :favorites_count,
             :created_at, :updated_at, :user_id,
             :about, :lunch_price, :dinner_price, :latitude, :longitude

  attribute :tables do |restaurant|
    restaurant.tables.map do |table|
      {
        number: table.number,
        seats: table.seats,
      }
    end
  end

  attribute :restaurant_hours do |restaurant|
    restaurant.restaurant_hours.map do |hour|
      {
        day_of_week: Date::DAYNAMES[hour.day_of_week],
        opens_at: hour.opens_at.strftime("%I:%M %p"),
        closes_at: hour.closes_at.strftime("%I:%M %p")
      }
    end
  end

  # Converts JSON:API response for cuisines to regular array
  attribute :cuisines do |restaurant|
    restaurant.cuisines.map(&:name)
  end

  attribute :photo_url do |restaurant, params|
    if restaurant.photo.attached?
      Rails.application.routes.url_helpers.url_for(restaurant.photo)
    else
      nil
    end
  end
end
