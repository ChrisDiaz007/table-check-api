class Api::V1::UsersController < Api::V1::BaseController

  def show
    @user = User.find(params[:id])
    authorize @user
    render json: UserSerializer.new(@user)
  end

end
