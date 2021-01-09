require 'test_helper'

class Api::V1::Admin::BaseLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
  end

  test 'should get index as admin' do
    get api_v1_admin_base_locations_path, headers: @admin_headers
    assert_response :success
    assert_equal BaseLocation.count, json['data'].size
  end

  test 'should get single record as admin' do
    get api_v1_admin_base_location_path(base_locations(:one)), headers: @admin_headers
    assert_response :success
  end

  test 'should create base location as admin' do
    assert_difference('BaseLocation.count') do
      VCR.use_cassette('admin base locations create') do
        post api_v1_admin_base_locations_path, params: {
          name: 'Harbor High', line1: '221 Lake Ave.', city: 'Ashtabula',
          state: 'Ohio', zip: '44004'
        }.to_json, headers: @admin_headers
      end
    end
  end

  test 'should update base location as admin' do
    patch api_v1_admin_base_location_path(base_locations(:one)),
                      params: { name: 'Test Place' }.to_json, headers: @admin_headers
    assert_response :success
    assert_equal base_locations(:one).reload.name, json['data']['attributes']['name']
  end

  test 'should destroy base location as admin' do
    assert_difference('BaseLocation.count', -1) do
      delete api_v1_admin_base_location_path(base_locations(:one)), headers: @admin_headers
    end
  end
end
