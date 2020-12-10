require 'test_helper'

class AdminServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
    @service = services(:one)
  end

  test 'should see all services as admin' do
    get api_v1_services_path, headers: @authorized_headers
    assert_response :success
    assert_equal Service.count, json['data'].size
  end

  test 'should get service as admin' do
    get api_v1_service_path(@service), headers: @authorized_headers
    assert_response :success
    assert_equal @service.id, json['data']['id'].to_i
  end

  test 'should create service as admin' do
    assert_difference('Service.count') do
      post api_v1_services_path, params: { service: {
        name: 'delivery', cost: 50, time_estimate: 15.minutes
          }
        }.to_json,
        headers: @authorized_headers
    end
    assert_response :success
  end

  test 'should update service as admin' do
    patch api_v1_service_path(@service), params: { service: {
      cost: 10.0 } }.to_json,
      headers: @authorized_headers
    assert_response :success
    assert_equal 10.0, @service.reload.cost
  end

  test 'should destroy service as admin' do
    service_count = Service.count
    delete api_v1_service_path(@service), headers: @authorized_headers
    assert_response :success
    assert_equal Service.count, service_count - 1
  end
end
