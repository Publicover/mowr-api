require 'test_helper'

class Api::V1::AdminServiceRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    fill_request_service_ids
    populate_blank_address
    @service_request = ServiceRequest.last
  end

  test 'should not get index as customer' do
    login_as_customer
    get api_v1_service_requests_path, headers: @authorized_headers
    assert_match Message.unauthorized, json['message']
  end

  test 'should get record as customer' do
    login_as_customer
    get api_v1_service_request_path(@service_request), headers: @authorized_headers
    assert_response :success
    assert_equal ServiceRequest.last.id, json['data']['id'].to_i
  end

  test 'should create as customer' do
    login_as_customer
    assert_difference('ServiceRequest.count') do
      post api_v1_service_requests_path, params: { service_request: {
        address_id: @address.id, approved: false, recurring: false,
        service_ids: [ServiceRequest.first.id] }
        }.to_json,
        headers: @authorized_headers
    end
    assert_response :success
  end

  test 'should update as customer' do
    login_as_customer
    patch api_v1_service_request_path(@service_request), params: { service_request:
        { approved: true }
      }.to_json, headers: @authorized_headers
    assert_response :success
    assert_equal true, @service_request.reload.approved
  end

  test 'should destroy as customer' do
    login_as_customer
    request_count = ServiceRequest.count
    delete api_v1_service_request_path(@service_request), headers: @authorized_headers
    assert_response :success
    assert_equal ServiceRequest.count, request_count - 1
  end

  def fill_request_service_ids
    ids = Service.pluck(:id)
    ServiceRequest.all.each { |record| record.update(service_ids: ids)}
  end
end
