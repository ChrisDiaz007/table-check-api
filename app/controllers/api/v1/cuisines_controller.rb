class Api::V1::CuisinesController < ApplicationController

  def index
    @cuisines = Cuisine.all

  render json: {
    data: @cuisines.order(id: :asc).map do |cuisine|
      {
        id: cuisine.id.to_s,
        type: "cuisine",
        attributes: {
          id: cuisine.id,
          name: cuisine.name,
          photo: cuisine&.photo.url
        }
      }
    end
  }
  end

  def show
    @cuisine = Cuisine.find(params[:id])
    render json: CuisineSerializer.new(@cuisine)
  end

  def update
    @cuisine = Cuisine.find(params[:id])

    if @cuisine.update(cuisine_params)
      render json: @cuisine, status: :ok
    else
      render json: { errors: @cuisine.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name, :photo)
  end

end
