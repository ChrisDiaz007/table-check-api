class Api::V1::TokensController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: [:refresh_token]
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def refresh_token
    refresh_token = request.headers['Refresh-Token'] || request.headers['HTTP_REFRESH_TOKEN']
    user = User.find_by(refresh_token: refresh_token)

    if user && user.refresh_token_expires_at && user.refresh_token_expires_at > Time.current
      new_refresh_token = SecureRandom.hex(32)
      user.update!(refresh_token: new_refresh_token, refresh_token_expires_at: 7.days.from_now)

      access_token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first

      render json: { access_token: access_token, refresh_token: new_refresh_token, refresh_token_expires_at: user.refresh_token_expires_at }, status: :ok
    else
      render json: { error: 'Invalid or expired refresh token' }, status: :unauthorized
    end
  end
end
