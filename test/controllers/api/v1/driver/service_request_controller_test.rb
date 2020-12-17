require 'test_helper'

class Api::V1::Driver::ServiceRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_driver
    fill_request_service_ids
    @service_request = ServiceRequest.last
  end

  test 'should get record as driver' do
    get api_v1_driver_service_request_path(@service_request), headers: @driver_headers
    assert_response :success
    assert @service_request.id, json['data']['id'].to_i
  end
end
