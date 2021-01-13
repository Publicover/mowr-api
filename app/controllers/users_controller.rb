# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token, user: user }
    add_stripe_customer(user)
    json_response(response, :created)
  end

  private

    def user_params
      params.permit(:f_name, :l_name, :email, :password, :password_confirmation, :role, :phone)
    end

    def add_stripe_customer(user)
      response = Stripe::Customer.create(
                         email: user.email,
                         description: "#{user.f_name} #{user.l_name} at #{user.phone}"
                         )
      user.update!(stripe_id: response[:id])
    end
end
