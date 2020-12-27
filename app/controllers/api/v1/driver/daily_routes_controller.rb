# frozen_string_literal: true

class Api::V1::Driver::DailyRoutesController < ApplicationController
  def show
    @daily_route = DailyRoute.find(params[:id])
    authorize [:api, :v1, @daily_route]
    serialized_response(@daily_route, DailyRoute)
  end
end
