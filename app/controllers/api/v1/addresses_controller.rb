class Api::V1::AddressesController < ApplicationController
  before_action :set_user, except: :index
  before_action :set_address, except: [:index, :create]

  def index
    @addresses = policy_scope([:api, :v1, Address])
    authorize [:api, :v1, @addresses]
    serialized_response(@addresses, Address)
  end

  def show
    serialized_response(@address, Address)
  end

  def create
    @address = Address.new(address_params)

    if @address.save
      serialized_response(@address, Address)
    end
  end

  def update
    @address.update(address_params)
    serialized_response(@address, Address)
  end

  def destroy
    @address.destroy!
    serialized_response(@address, Address)
  end

  private

    def set_user
      @user = User.find_by(id: params[:user_id])
    end

    def set_address
      @address = Address.find(params[:id])
      authorize [:api, :v1, @address]
    end

    def address_params
      params.require(:address).permit(:line_1, :line_2, :city, :state, :zip, :user_id)
    end
end
