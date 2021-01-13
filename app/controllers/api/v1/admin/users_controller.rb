# frozen_string_literal: true

class Api::V1::Admin::UsersController < ApplicationController
  before_action :set_user, except: [:index]

  def index
    @users = policy_scope([:api, :v1, User])
    authorize [:api, :v1, @users]
    serialized_response(@users, User)
  end

  def show
    authorize [:api, :v1, @user]
    serialized_response(@user, User)
  end

  def update
    authorize [:api, :v1, @user]
    @user.update(user_params)
    serialized_response(@user, User)
  end

  def destroy
    authorize [:api, :v1, @user]
    # TODO: test wiping customer from Stripe
    remove_stripe_customer unless Rails.env.test?
    @user.destroy!
    serialized_response(@user, User)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(policy([:api, :v1, User]).permitted_attributes)
    end

    def remove_stripe_customer
      stripe_id = User.find(params[:target_id]).stripe_id
      Stripe::Customer.delete(stripe_id)
    end
end
