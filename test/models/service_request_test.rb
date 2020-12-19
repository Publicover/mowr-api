require 'test_helper'

class ServiceRequestTest < ActiveSupport::TestCase
  setup do
    populate_service_request
  end

  test 'should return subtotal of services' do
    service_prices = Service.pluck(:price_per_driveway)
    price_index = Address.driveways[@address.driveway]
    prices = service_prices.each_with_object([]) do |service, memo|
      memo << service[price_index]
    end

    @service_request.service_ids = Service.pluck(:id)
    assert_equal prices.sum, @service_request.calculate_service_cost_subtotal
  end
end
