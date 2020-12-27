require 'test_helper'

class Api::V1::Admin::DailyRoutesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
    @daily_route = daily_routes(:one)
  end

  test 'should get all records as admin' do
    get api_v1_admin_daily_routes_path, headers: @admin_headers
    assert_response :success
    assert_equal DailyRoute.count, json['data'].size
  end

  test 'should get single record as admin' do
    get api_v1_admin_daily_route_path(@daily_route), headers: @admin_headers
    assert_response :success
    assert_equal @daily_route.id, json['data']['id'].to_i
  end

  test 'should create record as admin' do
    assert_difference('DailyRoute.count') do
      post api_v1_admin_daily_routes_path, params: { daily_route:
        { addresses_in_order: [4, 5, 6, 7, 8, 9] }
      }.to_json,
      headers: @admin_headers
    end
    assert_equal DailyRoute.last.addresses_in_order, [4, 5, 6, 7, 8, 9]
  end

  test 'should update single record as admin' do
    patch api_v1_admin_daily_route_path(@daily_route), params: {
        daily_route: { addresses_in_order: [100, 101, 102] }
      }.to_json,
      headers: @admin_headers
    assert_response :success
    assert_equal [100, 101, 102], @daily_route.reload.addresses_in_order
  end

  test 'should destroy single record as admin' do
    assert_difference('DailyRoute.count', -1) do
      delete api_v1_admin_daily_route_path(@daily_route), headers: @admin_headers
    end
  end
end
