require 'test_helper'

class Api::V1::Driver::BaseLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_driver
  end

  test 'should get all location as driver' do
    get api_v1_driver_base_locations_path, headers: @driver_headers
    assert_response :success
    assert_equal BaseLocation.count, json['data'].size
  end

  test 'should get single locaion as driver' do
    get api_v1_driver_base_location_path(base_locations(:one)), headers: @driver_headers
    assert_response :success
  end
end
