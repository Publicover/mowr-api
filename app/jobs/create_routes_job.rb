# frozen_string_literal: true

class CreateRoutesJob < ApplicationJob
  queue_as :default

  def perform(zip)
    return unless SnowAccumulation.last.inches.positive?
    return unless CurrentSnowfall.new.snowfall(zip) > 1

    result = CalculateDailyRoute.new.call
    latest_route = DailyRoute.last

    latest_route.addresses_in_order.each do |id|
      ServiceDelivery.create(address_id: id)
    end
  end
end
