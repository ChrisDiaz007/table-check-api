class Cuisine < ApplicationRecord
  #Restaurants
  has_many :cuisines_restaurants, dependent: :destroy
  has_many :restaurants, through: :cuisines_restaurants

  validates :name, presence: true, inclusion: { in: ["Sushi", "Kaiseki", "Shabu shabu", "Yakiniku", "Tempura", "Ramen",
  "Soba", "Udon", "Yakitori", "Japanese Curry", "Izakaya", "Italian", "French", "Chinese", "Cafe & brunch", "Desserts",
  "Wine & cocktails", "Burgers", "Okonomiyaki", "Korean", "Thai", "Indian", "Vietnamese", "American", "Entertainment",
  "Bar", "Korean BBQ"] }

end
