require 'test_helper'

class Api::V1::AdminServiceRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
    fill_request_service_ids
    populate_blank_address
    @service_request = ServiceRequest.last
  end

  test "should get index" do
    get api_v1_service_requests_path, headers: @authorized_headers
    assert_response :success
    assert_equal ServiceRequest.count, json['data'].size
  end

  test 'should get record as admin' do
    get api_v1_service_request_path(@service_request), headers: @authorized_headers
    assert_response :success
    assert_equal ServiceRequest.last.id, json['data']['id'].to_i
  end

  test 'should create as admin' do
    assert_difference('ServiceRequest.count') do
      post api_v1_service_requests_path, params: { service_request: {
        address_id: @address.id, approved: false, recurring: false,
        service_ids: [ServiceRequest.first.id] }
        }.to_json,
        headers: @authorized_headers
    end
    assert_response :success
  end

  test 'should update as admin' do
    patch api_v1_service_request_path(@service_request), params: { service_request:
        { approved: true }
      }.to_json, headers: @authorized_headers
    assert_response :success
    assert_equal true, @service_request.reload.approved
  end

  test 'should delete as admin' do
    request_count = ServiceRequest.count
    delete api_v1_service_request_path(@service_request), headers: @authorized_headers
    assert_response :success
    assert_equal ServiceRequest.count, request_count - 1
  end

  def fill_request_service_ids
    ids = Service.pluck(:id)
    ServiceRequest.all.each { |record| record.update(service_ids: ids)}
  end
end
