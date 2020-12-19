class Api::V1::Admin::ServiceDeliveriesController < ApplicationController
  before_action :set_service_delivery, except: [:index, :create]

  def index
    @service_deliveries = policy_scope([:api, :v1, ServiceDelivery])
    authorize [:api, :v1, @service_deliveries]

    serialized_response(@service_deliveries, ServiceDelivery)
  end

  def show
    serialized_response(@service_delivery, ServiceDelivery)
  end

  def create
    # TODO: calculate total price automatically here so admin only has to click
    #       confirm_params.require(:service_delivery).require(:confirm) or something
    @service_delivery = ServiceDelivery.new(service_delivery_params)
    authorize [:api, :v1, @service_delivery]

    if @service_delivery.save
      @service_delivery.confirm_siblings
      serialized_response(@service_delivery, ServiceDelivery)
    end
  end

  def update
    @service_delivery.update(service_delivery_params)
    serialized_response(@service_delivery, ServiceDelivery)
  end

  def destroy
    @service_delivery.destroy
    serialized_response(@service_delivery, ServiceDelivery)
  end

  private

    def set_service_delivery
      @service_delivery = ServiceDelivery.find(params[:id])
      authorize [:api, :v1, @service_delivery]
    end

    def service_delivery_params
      params.require(:service_delivery).permit(policy([:api, :v1, ServiceDelivery]).permitted_attributes)
    end
end
