class Api::V1::TokensController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: [:refresh_token]

  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def refresh_token
    user = User.find_by(refresh_token: token)

    # if user
      # new_access_token = JsonWebToken.encode(user_id: user.id) #User for JSON_web_token, disabled for now.

    if user && user.refresh_token_expires_at > Time.current
      # Issue new access token with Devise-JWT helper method:
      new_access_token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first

      render json: { access_token: new_access_token }, status: :ok
    else
      render json: { error: "Invalid token or expired refresh token" }, status: :unauthorized
    end
  end

  private

  def token
    request.headers['HTTP_REFRESH_TOKEN']
  end
end
