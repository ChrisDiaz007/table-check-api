class Api::V1::RestaurantsController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @restaurants = policy_scope(Restaurant)

    if params[:name].present?
      @restaurants = Restaurant.where('name ILIKE ?', "%#{params[:name]}%")
    else
    @restaurants = Restaurant.all
    end

    Rails.application.routes.default_url_options[:host] = request.base_url
    render json: RestaurantSerializer.new(@restaurants, { params: { host: request.base_url } })
    # Old version before Serializing to JSON:API response 👇
    # render json: @restaurants.map { |restaurant|
    #   restaurant.attributes.merge(
    #     photo_url: restaurant.photo.attached? ? url_for(restaurant.photo) : nil,
    #     cuisines: restaurant.cuisines.pluck(:name)
    #   )
    # }
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant

    Rails.application.routes.default_url_options[:host] = request.base_url
    render json: RestaurantSerializer.new(@restaurant, { params: { host: request.base_url } })
    # Old version before Serializing to JSON:API response 👇
    # render json: @restaurant.attributes.merge(
    #   photo_url: @restaurant.photo.attached? ? url_for(@restaurant.photo) : nil,
    #   cuisines: @restaurant.cuisines.pluck(:name)
    # )

    @markers =
    if @restaurant.geocoded?
      [{
        lat: @restaurant.latitude,
        lng: @restaurant.longitude,
      }]
    else
      []
    end
  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant
    if @restaurant.save
      render json: RestaurantSerializer.new(@restaurant, { params: { host: request.base_url } })
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
    if @restaurant.update(restaurant_params)
      render json: @restaurant, status: :updated
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
    @restaurant.destroy
  end

  def upload_photo
    restaurant = Restaurant.find(params[:restaurant_id])
    authorize restaurant
    if params[:photo].present?
      restaurant.photo.attach(params[:photo])
      render json: { message: "Photo uploaded successfully", url: url_for(restaurant.photo) }, status: :ok
    else
      render json: { error: "No photo attached" }, status: :unprocessable_entity
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :prefecture, :district, :description,
    :phone_number, :website, :total_tables, :about, :lunch_price, :dinner_price, :photo, cuisine_ids: [])
  end

end
