# frozen_string_literal: true

class Api::V1::Driver::BaseLocationsController < ApplicationController
  def index
    @base_locations = policy_scope([:api, :v1, BaseLocation])
    authorize [:api, :v1, @base_locations]
    serialized_response(@base_locations, BaseLocation)
  end

  def show
    @base_location = BaseLocation.find(params[:id])
    authorize [:api, :v1, @base_location]
    serialized_response(@base_location, BaseLocation)
  end
end
