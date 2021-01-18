# frozen_string_literal: true

class Api::V1::Admin::DailyRoutesController < ApplicationController
  before_action :set_daily_route, except: %i[index create]

  def index
    @daily_routes = policy_scope([:api, :v1, DailyRoute])
    authorize [:api, :v1, @daily_routes]
    serialized_response(@daily_routes)
  end

  def show
    serialized_response(@daily_route)
  end

  def create
    if daily_route_params[:calculate_route].present?
      CalculateDailyRoute.new.call
      @daily_route = DailyRoute.last
    else
      @daily_route = DailyRoute.new(daily_route_params)
    end
    authorize [:api, :v1, @daily_route]
    serialized_response(@daily_route) if @daily_route.save
  end

  def update
    @daily_route.update(daily_route_params)
    serialized_response(@daily_route) if @daily_route.save
  end

  def destroy
    @daily_route.destroy
    serialized_response(@daily_route)
  end

  private

    def set_daily_route
      @daily_route = DailyRoute.find(params[:id])
      authorize [:api, :v1, @daily_route]
    end

    def daily_route_params
      params.require(:daily_route).permit(policy([:api, :v1, DailyRoute]).permitted_attributes)
    end
end
