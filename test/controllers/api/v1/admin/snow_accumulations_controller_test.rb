require 'test_helper'

class Api::V1::Admin::SnowAccumulationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    snow_count = 2
    5.times do
      SnowAccumulation.create!(inches: snow_count)
      snow_count += 1
    end
    login_as_admin
  end

  test 'should get index as admin' do
    get api_v1_admin_snow_accumulations_path, headers: @admin_headers
    assert_response :success
    assert_equal SnowAccumulation.count, json['data'].size
  end

  test 'should see single record as admin' do
    get api_v1_admin_snow_accumulation_path(SnowAccumulation.first),
        headers: @admin_headers
    assert_response :success
    assert_equal SnowAccumulation.first.id, json['data']['id'].to_i
  end

  test 'should create as admin' do
    assert_difference('SnowAccumulation.count') do
      post api_v1_admin_snow_accumulations_path,
           params: { snow_accumulation: { inches: 5} }.to_json,
           headers: @admin_headers
    end
    assert_response :success
  end

  test 'should update as admin' do
    patch api_v1_admin_snow_accumulation_path(SnowAccumulation.last),
          params: { snow_accumulation: { inches: 11} }.to_json,
          headers: @admin_headers
    assert_response :success
    assert_equal 11, SnowAccumulation.last.reload.inches
  end

  test 'should destroy as admin' do
    assert_difference('SnowAccumulation.count', -1) do
      delete api_v1_admin_snow_accumulation_path(SnowAccumulation.last),
             headers: @admin_headers
    end
    assert_response :success
  end
end
