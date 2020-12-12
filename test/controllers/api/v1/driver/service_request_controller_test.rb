require 'test_helper'

class Api::V1::Driver::ServiceRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_driver
    fill_request_service_ids
    @service_request = ServiceRequest.last
  end

  test 'should not get index as driver' do
    get api_v1_driver_service_requests_path, headers: @authorized_headers
    assert_match Message.unauthorized, json['message']
  end

  test 'should get record as driver' do
    get api_v1_driver_service_request_path(@service_request), headers: @authorized_headers
    assert_response :success
    assert @service_request.id, json['data']['id'].to_i
  end

  test 'should not create, update or destroy as driver' do
    populate_blank_address
    post api_v1_driver_service_requests_path, params: { service_request: {
      address_id: @address.id, approved: false, recurring: false,
      service_ids: [ServiceRequest.first.id] }
      }.to_json,
      headers: @authorized_headers
    assert_match Message.unauthorized, json['message']

    patch api_v1_driver_service_request_path(@service_request), params: { service_request:
        { approved: true }
      }.to_json, headers: @authorized_headers
    assert_match Message.unauthorized, json['message']

    delete api_v1_driver_service_request_path(@service_request), headers: @authorized_headers
    assert_match Message.unauthorized, json['message']
  end
end
