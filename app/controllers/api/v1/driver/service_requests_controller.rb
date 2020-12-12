class Api::V1::Driver::ServiceRequestsController < ApplicationController
  before_action :set_service_request, except: [:index, :create]

  def index
    @service_requests = policy_scope([:api, :v1, ServiceRequest])
    authorize [:api, :v1, @service_requests]

    serialized_response(@service_requests, ServiceRequest)
  end

  def show
    serialized_response(@service_request, ServiceRequest)
  end

  def create
    @service_request = ServiceRequest.new(service_request_params)
    authorize [:api, :v1, @service_request]

    serialized_response(@service_request, ServiceRequest) if @service_request.save
  end

  def update
    @service_request.update(service_request_params)
    serialized_response(@service_request, ServiceRequest)
  end

  def destroy
    @service_request.destroy!
    serialized_response(@service_request, ServiceRequest)
  end

  private
    def set_service_request
      @service_request = ServiceRequest.find(params[:id])
      authorize [:api, :v1, @service_request]
    end

    def service_request_params
      params.require(:service_request).permit(policy([:api, :v1, ServiceRequest]).permitted_attributes)
    end
end
