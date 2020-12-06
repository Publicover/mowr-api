# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  before_action :set_user, except: [:index]

  def index
    @users = policy_scope([:api, :v1, User])
    authorize [:api, :v1, @users]
    render status: :ok, json: UserSerializer.new(@users).serialized_json
  end

  def show
    authorize [:api, :v1, @user]
    render status: :ok, json: UserSerializer.new(@user).serialized_json
  end

  def update
    authorize [:api, :v1, @user]
    @user.update(user_params)
    render status: :ok, json: UserSerializer.new(@user).serialized_json
  end

  def destroy
    authorize [:api, :v1, @user]
    @user.destroy!
    render status: :ok, json: UserSerializer.new(@user).serialized_json
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :f_name, :l_name, :password, :password_confirmation, :role, :target_id)
    end
end
