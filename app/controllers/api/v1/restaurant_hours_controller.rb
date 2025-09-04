class Api::V1::RestaurantHoursController < ApplicationController

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_hours = @restaurant.restaurant_hours
    # render json: @restaurant_hours.as_json(only: [:id, :day_of_week, :opens_at, :closes_at])
    render json: @restaurant_hours.map { |hour|
    {
      id: hour.id,
      day_of_week: hour.day_of_week,
      opens_at: hour.opens_at.strftime("%H:%M"),   # => "17:00"
      closes_at: hour.closes_at.strftime("%H:%M")  # => "23:00"
    }
  }
  end

  def create

  end

end
