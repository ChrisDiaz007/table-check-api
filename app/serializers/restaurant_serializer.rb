class RestaurantSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :address, :prefecture, :district,
             :description, :phone_number, :website,
             :total_tables, :followers_count, :favorites_count,
             :created_at, :updated_at, :user_id,
             :about, :lunch_price, :dinner_price, :latitude, :longitude, :tables

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
