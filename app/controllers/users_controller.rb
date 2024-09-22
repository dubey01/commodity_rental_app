# frozen_string_literal: true

# controller class for managing users
class UsersController < ApplicationController
  before_action :validate_user_type

  def create
    new_user = User.new(user_params)
    if new_user.save!
      render json: { status: 'success', message: 'user created successfully', payload: { user_id: new_user.reload.id } },
             status: :ok
    end
  rescue StandardError => e
    render json: { status: 'error', message: 'user could not be created', payload: { error: e } },
           status: :unprocessable_entity
  end

  private

  def validate_user_type
    types = %w[lender renter]

    raise 'Invalid User Type' unless types.include?(user_params[:type])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :gender, :type, :phone_no)
  end
end
