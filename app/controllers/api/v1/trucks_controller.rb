# frozen_string_literal: true

class Api::V1::TrucksController < ApplicationController
  before_action :set_truck, except: %i[index create]
  def index
    @trucks = policy_scope([:api, :v1, Truck])
    authorize [:api, :v1, @trucks]
    serialized_response(@trucks, Truck)
  end

  def show
    serialized_response(@truck, Truck)
  end

  def create
    @truck = Truck.new(truck_params)
    authorize [:api, :v1, @truck]

    serialized_response(@truck, Truck) if @truck.save
  end

  def update
    @truck.update(truck_params)

    serialized_response(@truck, Truck)
  end

  def destroy
    @truck.destroy
    serialized_response(@truck, Truck)
  end

  private

    def set_truck
      @truck = Truck.find(params[:id])
      authorize [:api, :v1, @truck]
    end

    def truck_params
      params.require(:truck).permit(policy([:api, :v1, Truck]).permitted_attributes)
    end
end
