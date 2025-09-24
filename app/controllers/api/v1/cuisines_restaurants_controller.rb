class Api::V1::CuisinesRestaurantsController < ApplicationController

  def update
    @restaurant = Restaurant.find(params[:id])
    cuisine_names = params[:cuisines]
    # convert names to IDs
    cuisine_ids = Cuisine.where(name: cuisine_names).pluck(:id)

    if cuisine_ids.present?
      @restaurant.cuisine_ids = cuisine_ids
      render json: { message: "Cuisines updated successfully", cuisines: @restaurant.cuisines.as_json(only: [:id, :name]) }, status: :ok
    else
      render json: { error: "No valid cuisines provided" }, status: :unprocessable_entity
    end
  end

end
