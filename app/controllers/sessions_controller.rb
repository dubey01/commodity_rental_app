# frozen_string_literal: true

# class for managing user login session
class SessionsController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # Login action
  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
