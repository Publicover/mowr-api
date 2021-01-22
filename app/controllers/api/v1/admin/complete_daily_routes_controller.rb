# frozen_string_literal: true

class Api::V1::Admin::CompleteDailyRoutesController < ApplicationController
  def update
    @daily_route = DailyRoute.find(params[:id])
    authorize [:api, :v1, @daily_route]

    @daily_route.addresses.each do |address|
      next unless address.serve_today?

      StripePayment.capture_and_charge(address.current_charges, address.user)

      address.mark_serviced
    end
  end
end
