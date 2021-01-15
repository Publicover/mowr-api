require 'test_helper'

class ServiceDeliveryTest < ActiveSupport::TestCase
  setup do
    @snow_accumulation = snow_accumulations(:one)
    @address = addresses(:one)
    @size_estimate = @address.size_estimate
    @service_request = @address.service_request
  end

  test 'should know sibling service_request' do
    service_delivery = ServiceDelivery.create!(address_id: @address.id)
    refute service_delivery.service_request.blank?
  end

  test 'should know sibling size_estimate' do
    service_delivery = ServiceDelivery.create!(address_id: @address.id)
    refute service_delivery.size_estimate.blank?
  end

  test 'should calculate total cost before save' do
    service_delivery = ServiceDelivery.create!(address_id: @address.id)
    subtotal = service_delivery.service_request.service_subtotal
    services = Service.find(service_delivery.service_request.service_ids)
    prices = services.each_with_object([]) do |service, memo|
      memo << (service.price_per_inch_of_snow * SnowAccumulation.last.inches)
    end
    subtotal += prices.sum
    subtotal *= ServiceDelivery::STATE_TAX

    assert_equal subtotal, service_delivery.reload.total_cost
  end

end
