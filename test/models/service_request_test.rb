require 'test_helper'

class ServiceRequestTest < ActiveSupport::TestCase
  setup do
    @address = populate_blank_address
    @service_request = ServiceRequest.create(address_id: @address.id, status: :pending, service_ids: Service.pluck(:id))
    @size_estimate = SizeEstimate.create(address_id: @address.id, status: :pending)
  end

  test 'should return subtotal of services before save' do
    services = Service.find(@service_request.service_ids)
    price_index = Address.driveways[@service_request.address.driveway]
    prices = services.each_with_object([]) do |service, memo|
      memo << service.price_per_driveway[price_index]
    end

    assert_equal prices.sum, @service_request.service_subtotal
  end
end
