class Cuisine < ApplicationRecord
  #Restaurants
  has_many :cuisines_restaurants, dependent: :destroy
  has_many :restaurants, through: :cuisines_restaurants
end
