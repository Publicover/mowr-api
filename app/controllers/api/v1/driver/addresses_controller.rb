# frozen_string_literal: true

class Api::V1::Driver::AddressesController < ApplicationController
  before_action :set_user, except: :index
  before_action :set_address, except: %i[index create]

  def index
    @addresses = policy_scope([:api, :v1, Address])
    authorize [:api, :v1, @addresses]
    serialized_response(@addresses)
  end

  def show
    serialized_response(@address)
  end

  def create
    @address = Address.new(address_params)
    authorize [:api, :v1, @address]

    serialized_response(@address) if @address.save
  end

  def update
    @address.update(address_params)
    # if params['estimate_confirmed'].present?
    #   puts "YES!"
    # else
    #   puts "NO!"
    #   puts params
    # end
    # if params[:city].present?
    #   puts 'YES!'
    # else
    #   puts params
    # end
    @address.size_estimate.confirmed! if address_params[:estimate_confirmed].present?
    serialized_response(@address)
  end

  def destroy
    @address.destroy!
    serialized_response(@address)
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
      params.require(:address).permit(policy([:api, :v1, Address]).permitted_attributes)
    end
end
