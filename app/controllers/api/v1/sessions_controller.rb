class Api::V1::SessionsController < Devise::SessionsController
  include RackSessionFix
  respond_to :json

  private

  def respond_with(resource, _opts = {})

  # Generates new refresh_token and stores in DB(server)
  refresh_token = SecureRandom.hex(32)
  resource.update(refresh_token: refresh_token, refresh_token_expires_at: 7.days.from_now)

  # Devise-jwt issues this access token
  access_token = request.env['warden-jwt_auth.token']

  # Set secured HTTP-only cookie for refresh token(frontend cannot read this cookie)
  cookies.signed[:refresh_token] = {
    value: refresh_token,
    httponly: true,
    secure: Rails.env.production?,
    same_site: :lax,
    expires: 7.days.front_now
  }

    render json: {
      status: {code: 200, message: 'Logged in successfully.'},
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
      access_token: access_token,
      # refresh_token: refresh_token,
      refresh_token_expires_at: resource.refresh_token_expires_at
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      # Clears refresh token on logout
      current_user.update(refresh_token: nil)
      cookies.delete(:refresh_token) # deletes http token

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
