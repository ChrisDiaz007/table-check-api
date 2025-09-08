class Api::V1::ReservationsController < ApplicationController
  # before_action :authenticate_user!

  # def index
  #   @restaurant = Restaurant.find(params[:restaurant_id])
  #   @reservations = @restaurant.reservations
  #   render json: ReservationSerializer.new(@reservations)
  # end

  # def show
  #   @restaurant = Restaurant.find(params[:restaurant_id])
  #   @reservation = @restaurant.reservations.find(params[:id])
  #   render json: @reservation
  # end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.restaurant = @restaurant
    @reservation.user = current_user

    # authorize @reservation

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_content
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit( :party_size, :reservation_time, :status)
  end

end
