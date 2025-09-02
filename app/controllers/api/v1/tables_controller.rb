class Api::V1::TablesController < ApplicationController
  # before_action :set_restaurant

  def index
    @tables = Table.all
    render json: @tables
  end

  def create
    @table = Table.new(table_params)
    @table.user = current_user
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
