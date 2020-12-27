class Api::V1::Admin::DailyRoutesController < ApplicationController
  before_action :set_daily_route, except: [:index, :create]

  def index
    @daily_routes = policy_scope([:api, :v1, DailyRoute])
    authorize [:api, :v1, @daily_routes]
    serialized_response(@daily_routes, DailyRoute)
  end

  def show
    serialized_response(@daily_route, DailyRoute)
  end

  def create
    @daily_route = DailyRoute.new(daily_route_params)
    serialized_response(@daily_route, DailyRoute) if @daily_route.save
  end

  def update
    @daily_route.update(daily_route_params)
    # binding.pry
    serialized_response(@daily_route, DailyRoute) if @daily_route.save
  end

  def destroy
    @daily_route.destroy
    serialized_response(@daily_route, DailyRoute)
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
