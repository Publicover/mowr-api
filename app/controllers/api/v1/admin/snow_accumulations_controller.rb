# frozen_string_literal: true

class Api::V1::Admin::SnowAccumulationsController < ApplicationController
  before_action :set_snow_accumulation, except: %i[index create]

  def index
    @snow_accumulations = policy_scope([:api, :v1, SnowAccumulation])
    authorize [:api, :v1, @snow_accumulations]

    serialized_response(@snow_accumulations, SnowAccumulation)
  end

  def show
    serialized_response(@snow_accumulation, SnowAccumulation)
  end

  def create
    @snow_accumulation = SnowAccumulation.new(snow_accumulation_params)

    serialized_response(@snow_accumulation, SnowAccumulation) if @snow_accumulation.save
  end

  def update
    @snow_accumulation.update(snow_accumulation_params)
    serialized_response(@snow_accumulation, SnowAccumulation)
  end

  def destroy
    @snow_accumulation.destroy
    serialized_response(@snow_accumulation, SnowAccumulation)
  end

  private

    def set_snow_accumulation
      @snow_accumulation = SnowAccumulation.find(params[:id])
      authorize [:api, :v1, @snow_accumulation]
    end

    def snow_accumulation_params
      params.require(:snow_accumulation).permit(policy([:api, :v1, SnowAccumulation]).permitted_attributes)
    end
end
