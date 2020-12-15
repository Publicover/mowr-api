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

  test 'should not get create, update or destroy as driver' do
    post api_v1_driver_services_path, params: { service: {
      name: 'Test Service', price_per_quarter_hour: 30.0
        }
      }.to_json,
      headers: @driver_headers
    assert_match Message.unauthorized, json['message']

    patch api_v1_driver_service_path(@service), params: { service: {
      name: 'Just Give Us Money'
        }
      }.to_json,
      headers: @driver_headers
    assert_match Message.unauthorized, json['message']

    delete api_v1_driver_service_path(@service), headers: @driver_headers
    assert_match Message.unauthorized, json['message']
  end
end
