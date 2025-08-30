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

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      render json: UserSerializer.new(@user)
    else
      render json: { errors: @user.errors.full_message }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number)
  end

end
