class Api::V1::SessionsController < Devise::SessionsController
  include RackSessionFix
  respond_to :json

  private

  def respond_with(resource, _opts = {})

    token = request.env['warden-jwt_auth.token'] # JWT access token from devise-jwt

    # Generate a new refresh token and save it
    refresh_token = SecureRandom.hex(32)
    resource.update(refresh_token: refresh_token)

    response.set_header('Authorization', "Bearer #{token}") # Set access token in header

    render json: {
      status: {code: 200, message: 'Logged in successfully.'},
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
      access_token: token,
      refresh_token: refresh_token,
      refresh_token_expires_at: 7.days.from.now
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      current_user.update(refresh_token: nil) # Clears refresh token on logout

      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

end
