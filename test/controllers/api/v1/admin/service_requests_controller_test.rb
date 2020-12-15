require 'test_helper'

class Api::V1::Admin::ServiceRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
    fill_request_service_ids
    @service_request = ServiceRequest.last
  end

  test "should get index" do
    get api_v1_admin_service_requests_path, headers: @admin_headers
    assert_response :success
    assert_equal ServiceRequest.count, json['data'].size
  end

  test 'should get record as admin' do
    get api_v1_admin_service_request_path(@service_request), headers: @admin_headers
    assert_response :success
    assert_equal ServiceRequest.last.id, json['data']['id'].to_i
  end

  test 'should create as admin' do
    populate_blank_address
    assert_difference('ServiceRequest.count') do
      post api_v1_admin_service_requests_path, params: { service_request: {
        address_id: @address.id, approved: false, recurring: false,
        service_ids: [ServiceRequest.first.id] }
        }.to_json,
        headers: @admin_headers
    end
    assert_response :success
  end

  test 'should update as admin' do
    patch api_v1_admin_service_request_path(@service_request), params: { service_request:
        { approved: true }
      }.to_json, headers: @admin_headers
    assert_response :success
    assert_equal true, @service_request.reload.approved
  end

  test 'should delete as admin' do
    request_count = ServiceRequest.count
    delete api_v1_admin_service_request_path(@service_request), headers: @admin_headers
    assert_response :success
    assert_equal ServiceRequest.count, request_count - 1
  end
end
