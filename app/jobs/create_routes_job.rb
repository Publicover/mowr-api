# frozen_string_literal: true

class CreateRoutesJob < ApplicationJob
  queue_as :default

  def perform(zip)
    if SnowAccumulation.last.inches > 0
      if CurrentSnowfall.new.snowfall(zip) > 1
        result = CalculateDailyRoute.new.call
        latest_route = DailyRoute.create(addresses_in_order: result)

        latest_route.addresses_in_order.each do |id|
          ServiceDelivery.create(address_id: id)
        end
      end
    end
  end
end
