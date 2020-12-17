# frozen_string_literal: true

class Api::V1::Driver::ServicesController < ApplicationController
  def index
    @services = policy_scope([:api, :v1, Service])
    authorize [:api, :v1, @services]
    serialized_response(@services, Service)
  end

  def show
    @service = Service.find(params[:id])
    authorize [:api, :v1, @service]
    serialized_response(@service, Service)
  end
end
