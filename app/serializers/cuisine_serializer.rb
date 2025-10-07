class CuisineSerializer
  include JSONAPI::Serializer
  attributes :id, :name

  attribute :restaurants do |cuisine|
    cuisine.restaurants.map do |restaurant|
      {
        id: restaurant.id,
        name: restaurant.name,
        address: restaurant.address,
        about: restaurant.about,
        lunch_price: restaurant.lunch_price,
        dinner_price: restaurant.dinner_price,
        cuisines: restaurant.cuisines.map do |cuisine|
          {
            id: cuisine.id,
            name: cuisine.name,
          }
        end,
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
