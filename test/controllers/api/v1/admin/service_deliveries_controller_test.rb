require 'test_helper'

class Api::V1::Admin::ServiceDeliveriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
    @service_delivery = ServiceDelivery.all.sample
  end

  test 'should get all service deliveries as admin' do
    get api_v1_admin_service_deliveries_path, headers: @admin_headers
    assert_response :success
    assert_equal ServiceDelivery.count, json['data'].size
  end

  test 'should get any service delivery as admin' do
    get api_v1_admin_service_delivery_path(@service_delivery), headers: @admin_headers
    assert_response :success
    assert_equal @service_delivery.id, json['data']['id'].to_i
  end

  test 'should create service delivery as admin' do
    populate_service_request

    assert_difference('ServiceDelivery.count') do
      post api_v1_admin_service_deliveries_path,
           params: { service_delivery: {
             total_cost: 300.0,
             address_id: @address.id
            }
          }.to_json,
          headers: @admin_headers
    end
    assert_response :success
  end

  test 'should update any service delivery as admin' do
    patch api_v1_admin_service_delivery_path(@service_delivery), params: {
        service_delivery: {
          total_cost: 500.0
        }
      }.to_json,
      headers: @admin_headers
    assert_response :success
    assert_equal @service_delivery.id, json['data']['id'].to_i
  end

  test 'should destroy any service delivery as admin' do
    assert_difference('ServiceDelivery.count', -1) do
      delete api_v1_admin_service_delivery_path(@service_delivery), headers: @admin_headers
    end
    assert_response :success
  end

  test 'creation confirms siblings' do
    populate_service_request

    post api_v1_admin_service_deliveries_path,
         params: { service_delivery: {
           total_cost: 300.0,
           address_id: @address.id
          }
        }.to_json,
        headers: @admin_headers
    assert @service_request.reload.confirmed?
    assert @size_estimate.reload.confirmed?
  end
end
