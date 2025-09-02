class Api::V1::ReservationsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @reservation = Reservation.all
    render json: @reservation
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reservation = @restaurant.reservations
    render json: @reservation
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.restaurant = @restaurant
    @reservation.user = current_user

    # If you want to choose a specific table from the client
    if reservation_params[:table_id].present?
      @reservation.table = @restaurant.tables.find(reservation_params[:table_id])
    else
      @reservation.table = @restaurant.tables.first
    end

    # authorize @reservation

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
    end

  end

  private

  def reservation_params
    params.require(:reservation).permit( :table_id, :party_size, :reservation_time)
  end

end
