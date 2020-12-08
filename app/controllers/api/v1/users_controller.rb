# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
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
    @user.destroy!
    serialized_response(@user, User)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :f_name, :l_name, :password, :password_confirmation, :role, :target_id)
    end
end
