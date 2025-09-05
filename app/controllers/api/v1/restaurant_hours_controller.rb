class Api::V1::RestaurantHoursController < ApplicationController

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_hours = @restaurant.restaurant_hours.order(:day_of_week)
    render json: RestaurantHourSerializer.new(@restaurant_hours)
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

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_hour = @restaurant.restaurant_hours.find(params[:id])
    # authorize @restaurant
    if @restaurant_hour.update(restaurant_hour_params)
      render json: @restaurant_hour
    else
      render json: { errors: @restaurant_hour.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def restaurant_hour_params
    params.require(:restaurant_hour).permit(:day_of_week, :opens_at, :closes_at)
  end

end
