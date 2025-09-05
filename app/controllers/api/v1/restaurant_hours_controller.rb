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
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_hour = RestaurantHour.new(restaurant_hour_params)
    @restaurant_hour.restaurant = @restaurant

    if @restaurant_hour.save
      render json: @restaurant_hour, status: :created
    else
      rended json: { errors: @restaurant_hour.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def restaurant_hour_params
    params.require(:restaurant_hour).permit(:day_of_week, :opens_at, :closes_at)
  end

end
