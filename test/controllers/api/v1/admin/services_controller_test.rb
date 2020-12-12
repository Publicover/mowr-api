require 'test_helper'

class Api::V1::Admin::ServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
    @service = Service.first
  end

  test 'should get index as admin' do
    get api_v1_admin_services_path, headers: @authorized_headers
    assert_response :success
    assert_equal Service.count, json['data'].size
  end

  test 'should get record as admin' do
    get api_v1_admin_service_path(@service), headers: @authorized_headers
    assert_response :success
    assert_equal @service.id, json['data']['id'].to_i
  end

  test 'should create as admin' do
    assert_difference('Service.count') do
      post api_v1_admin_services_path, params: { service: {
        name: 'Test Service', price_per_quarter_hour: 30.0
          }
        }.to_json,
        headers: @authorized_headers
    end
    assert_response :success
  end

  test 'should update as admin' do
    patch api_v1_admin_service_path(@service), params: { service: {
      name: 'Just Give Us Money'
        }
      }.to_json,
      headers: @authorized_headers
    assert_response :success
    assert_equal 'Just Give Us Money', @service.reload.name
  end

  test 'should destroy as admin' do
    service_count = Service.count
    delete api_v1_admin_service_path(@service), headers: @authorized_headers
    assert_response :success
    assert_equal Service.count, service_count - 1
  end

end
