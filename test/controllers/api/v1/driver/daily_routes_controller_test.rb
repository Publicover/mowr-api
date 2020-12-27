require 'test_helper'

class Api::V1::Driver::DailyRoutesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_driver
    @daily_route = daily_routes(:one)
  end

  test "should get single record as driver" do
    get api_v1_driver_daily_route_path(@daily_route), headers: @driver_headers
    assert_response :success
  end

end
