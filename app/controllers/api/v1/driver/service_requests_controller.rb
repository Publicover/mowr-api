# frozen_string_literal: true

class Api::V1::Driver::ServiceRequestsController < ApplicationController
  def show
    @service_request = ServiceRequest.find(params[:id])
    authorize [:api, :v1, @service_request]
    serialized_response(@service_request, ServiceRequest)
  end
end
