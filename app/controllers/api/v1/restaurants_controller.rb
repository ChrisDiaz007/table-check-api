class Api::V1::RestaurantsController < ApplicationController

  def index
    if params[:name].present?
      @restaurants = Restaurant.where('name ILIKE ?', "%#{params[:name]}%")
    else
      @restaurants = Restaurant.all
    end
    render json: @restaurants
  end

end
