require 'test_helper'

class Mutations::ServiceDeliveryTest < ActionDispatch::IntegrationTest
  setup do
    populate_service_request
  end

  test 'should create service delivery as admin' do
    graphql_as_admin

    assert_difference('ServiceDelivery.count') do
      post graphql_path, params: { query: add_service_delivery_helper(@address.id) }
    end

    assert_response :success
  end

  # test 'should update service delivery as admin' do
    # There's not really anything in this record that can be changed
    # so I'm skipping this test.
  # end
end
