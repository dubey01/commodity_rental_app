# frozen_string_literal: true

# base class of all controllers
class ApplicationController < ActionController::Base
  # Before action to authenticate the user
  before_action :authorize_request

  # Encode the payload to generate a JWT token
  def encode_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  # Decode the token to get the payload
  def decoded_token
    # Check for the token in the Authorization header
    auth_header = request.headers['Authorization']
    return unless auth_header

    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      Rails.logger.error 'Error in decoding the JWT token'
      nil
    end
  end

  # Get the current logged-in user from the decoded JWT token
  def current_user
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @current_user = User.find_by(id: user_id)
  end

  # Check if the user is logged in
  def logged_in?
    current_user.present?
  end

  # Authorize the request
  def authorize_request
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
