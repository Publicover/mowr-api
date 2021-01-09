class Api::V1::Admin::BaseLocationsController < ApplicationController
  before_action :set_base_location, except: [:index, :create]

  def index
    @base_locations = policy_scope([:api, :v1, BaseLocation])
    authorize [:api, :v1, @base_locations]

    serialized_response(@base_locations, BaseLocation)
  end

  def show
    serialized_response(@base_location, BaseLocation)
  end

  def create
    @base_location = BaseLocation.new(base_location_params)
    authorize [:api, :v1, @base_location]

    serialized_response(@base_location, BaseLocation) if @base_location.save
  end

  def update
    @base_location.update(base_location_params)
    serialized_response(@base_location, BaseLocation)
  end

  def destroy
    @base_location.destroy
    serialized_response(@base_location, BaseLocation)
  end

  private

    def set_base_location
      @base_location = BaseLocation.find(params[:id])
      authorize [:api, :v1, @base_location]
    end

    def base_location_params
      params.require(:base_location).permit(:name, :line1, :line2, :city, :state, :zip, :latitude, :longitude)
    end
end
