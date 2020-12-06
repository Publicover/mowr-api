# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  before_action :set_user, except: [:index]

  def index
    # if current_user.admin?
    #   @users = User.all
    #   json_response(@users)
    # else
    #   json_response({ message: Message.invalid_credentials })
    # end
    @users = policy_scope([:api, :v1, User])
    authorize [:api, :v1, @users]
    # authorize @users
    json_response(@users)
  end

  def show
    # @user = if current_user.admin?
    #           User.find(params[:target_id])
    #         else
    #           User.find(params[:id])
    #         end
    # @user = User.find(params[:id])
    authorize [:api, :v1, @user]
    json_response(@user)
    # UserSerializer.new(@user).serialized_json
  end

  def update
    # @user = if current_user.admin?
    #           User.find(params[:target_id])
    #         else
    #           User.find(params[:id])
    #         end
    authorize [:api, :v1, @user]
    @user.update(user_params)
    json_response(@user)
  end

  def destroy
    # @user = if current_user.admin?
    #           User.find(params[:target_id])
    #         else
    #           User.find(params[:id])
    #         end
    authorize [:api, :v1, @user]
    @user.destroy!
    json_response(@user)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :f_name, :l_name, :password, :password_confirmation, :role, :target_id)
    end
end
