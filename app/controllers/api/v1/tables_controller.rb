class Api::V1::TablesController < ApplicationController
  # before_action :set_restaurant

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @tables = @restaurant.tables.order(:number)
    render json: TableSerializer.new(@tables)
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

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @tables = @restaurant.tables.find(params[:id])
    # authorize @restaurant
    if @tables.update(table_params)
      render json: @tables
    else
      render json: { errors: @tables.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def table_params
    params.require(:table).permit( :number, :seats)
  end

end
