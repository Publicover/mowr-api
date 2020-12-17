require 'test_helper'

class Api::V1::Driver::ServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_driver
    @service = Service.first
  end

  test 'should get index as driver' do
    get api_v1_driver_services_path, headers: @driver_headers
    assert_response :success
    assert_equal Service.count, json['data'].size
  end

  test 'should get record as driver' do
    get api_v1_driver_service_path(@service), headers: @driver_headers
    assert_response :success
    assert_equal Service.first.id, json['data']['id'].to_i
  end
end
