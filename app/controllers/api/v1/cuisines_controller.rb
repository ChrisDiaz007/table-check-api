class Api::V1::CuisinesController < ApplicationController

  def index
    @cuisines = Cuisine.all

  render json: {
    data: @cuisines.map do |cuisine|
      {
        id: cuisine.id.to_s,
        type: "cuisine",
        attributes: {
          id: cuisine.id,
          name: cuisine.name
        }
      }
    end
  }
  end

  def show
    @cuisine = Cuisine.find(params[:id])
    render json: CuisineSerializer.new(@cuisine)
  end

end
