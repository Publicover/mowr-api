# frozen_string_literal: true

class Api::V1::Driver::PlowsController < ApplicationController
  before_action :set_plow, except: %i[index create]
  def index
    @plows = policy_scope([:api, :v1, Plow])
    authorize [:api, :v1, @plows]
    serialized_response(@plows)
  end

  def show
    serialized_response(@plow)
  end

  def create
    @plow = Plow.new(plow_params)
    authorize [:api, :v1, @plow]

    serialized_response(@plow) if @plow.save
  end

  def update
    @plow.update(plow_params)

    serialized_response(@plow)
  end

  def destroy
    @plow.destroy
    serialized_response(@plow)
  end

  private

    def set_plow
      @plow = Plow.find(params[:id])
      authorize [:api, :v1, @plow]
    end

    def plow_params
      params.require(:plow).permit(policy([:api, :v1, Plow]).permitted_attributes)
    end
end
