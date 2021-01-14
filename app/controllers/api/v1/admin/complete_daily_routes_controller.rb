# frozen_string_literal: true

class Api::V1::Admin::CompleteDailyRoutesController < ApplicationController
  def update
    @daily_route = DailyRoute.find(params[:id])
    authorize @daily_route

    @daily_route.addresses.each do |address|
      next unless address.serve_today?

      StripePayment.capture_and_charge(address.current_charges, address.user)
      # Payment.create(address.current_delivery.id)
      address.mark_serviced
    end
  end
end
