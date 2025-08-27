class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: [ :restaurants ]

  def show
    @user = User.find(params[:id])
    authorize @user
    render json: UserSerializer.new(@user)
  end

  def restaurants
    @user = User.find(params[:id])
    authorize @user
    @restaurants = @user.restaurants

    Rails.application.routes.default_url_options[:host] = request.base_url
    render json: RestaurantSerializer.new(@restaurants, { params: { host: request.base_url } })
  end

end
