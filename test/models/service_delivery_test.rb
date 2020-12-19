require 'test_helper'

class ServiceDeliveryTest < ActiveSupport::TestCase
  setup do
    populate_service_request
    @service_delivery = ServiceDelivery.create!(address_id: @address.id, total_cost: 0)
  end

  test 'should know sibling service_request' do
    refute @service_delivery.service_request.blank?
  end

  test 'should know sibling size_estimate' do
    refute @service_delivery.size_estimate.blank?
  end

end
