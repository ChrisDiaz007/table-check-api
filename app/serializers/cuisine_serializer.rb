class CuisineSerializer
  include JSONAPI::Serializer
  attributes :id, :name

  attribute :restaurants do |cuisine|
    cuisine.restaurants.map do |restaurant|
      {
        id: restaurant.id,
        name: restaurant.name,
        address: restaurant.address,
        prefecture: restaurant.prefecture,
        district: restaurant.district,
        phone_number: restaurant.phone_number,
        latitude: restaurant.latitude,
        longitude: restaurant.longitude,
        photo: restaurant.photo.url
      }
    end
  end
end
