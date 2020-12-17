require 'test_helper'

class Api::V1::Customer::ServiceRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_customer
    fill_request_service_ids
    @service_request = ServiceRequest.last
  end

  test 'should get own records as customer' do
    get api_v1_customer_service_requests_path, headers: @customer_headers
    assert_response :success
    assert @customer.service_requests.count, json['data'].size
  end

  test 'should get record as customer' do
    get api_v1_customer_service_request_path(@service_request), headers: @customer_headers
    assert_response :success
    assert_equal ServiceRequest.last.id, json['data']['id'].to_i
  end

  test 'should create as customer' do
    populate_blank_address
    assert_difference('ServiceRequest.count') do
      post api_v1_customer_service_requests_path, params: { service_request: {
        address_id: @address.id, approved: false, recurring: false,
        service_ids: [ServiceRequest.first.id] }
        }.to_json,
        headers: @customer_headers
    end
    assert_response :success
  end

  test 'should update as customer' do
    patch api_v1_customer_service_request_path(@service_request), params: { service_request:
        { approved: true }
      }.to_json, headers: @customer_headers
    assert_response :success
    assert_equal true, @service_request.reload.approved
  end

  test 'should destroy as customer' do
    request_count = ServiceRequest.count
    delete api_v1_customer_service_request_path(@service_request), headers: @customer_headers
    assert_response :success
    assert_equal ServiceRequest.count, request_count - 1
  end
end
