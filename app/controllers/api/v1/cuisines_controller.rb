class Api::V1::CuisinesController < ApplicationController

  def index
    @cuisines = Cuisine.all
    render json: @cuisines
  end

end
