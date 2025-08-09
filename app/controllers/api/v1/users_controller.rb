class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @users = User.all
    @users = policy_scope(User)
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
    render json: UserSerializer.new(@user)
  end
end
