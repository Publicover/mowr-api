require 'test_helper'

class Mutations::ServiceTest < ActionDispatch::IntegrationTest
  test 'should add service as admin' do
    graphql_as_admin

    assert_difference('Service.count') do
      post graphql_path, params: { query: create_service_helper }
    end

    assert_response :success
  end

  test 'should update any any service as admin' do
    price = 15
    graphql_as_admin

    post graphql_path, params: { query: update_service_helper(services(:one).id, price) }
    assert_response :success
    assert_equal services(:one).reload.price_per_inch_of_snow, price
  end

  test 'should destroy any service as admin' do
    graphql_as_admin

    post graphql_path, params: { query: destroy_service_helper(services(:one).id) }

    assert_response :success
    assert_equal Message.is_deleted(services(:one)), json['data']['destroyService']['isDeleted']
  end
end
