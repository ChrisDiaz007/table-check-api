class Api::V1::RestaurantsController < ApplicationController

  def index
    if params[:name].present?
      @restaurants = Restaurant.where('name ILIKE ?', "%#{params[:name]}%")
    else
      @restaurants = Restaurant.all
    end
    render json: @restaurants.map { |restaurant|
      restaurant.attributes.merge(
        photo_url: restaurant.photo.attached? ? url_for(restaurant.photo) : nil
      )
    }
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    render json: @restaurant.attributes.merge(
      photo_url: @restaurant.photo.attached? ? url_for(@restaurant.photo) : nil
    )
  end

  def upload_photo
    restaurant = Restaurant.find(params[:restaurant_id])

    if params[:photo].present?
      restaurant.photo.attach(params[:photo])
      render json: { message: "Photo uploaded successfully", url: url_for(restaurant.photo) }, status: :ok
    else
      render json: { error: "No photo attached" }, status: :unprocessable_entity
    end
  end

end
