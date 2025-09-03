class Api::V1::TablesController < ApplicationController
  # before_action :set_restaurant

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @tables = @restaurant.tables
    render json: @tables
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @table = Table.new(table_params)
    @table.restaurant = @restaurant

    # authorize @table
    if @table.save
      render json: @table, status: :created
    else
      render json: { errors: @table.errors.full_messages }, status: :unprocessable_entity
    end

  end

  private

  def table_params
    params.require(:table).permit( :number, :seats)
  end

end
