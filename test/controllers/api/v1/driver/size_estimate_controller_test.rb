require 'test_helper'

class Api::V1::Driver::SizeEstimatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_driver
    populate_size_estimates
    @random_se_id = SizeEstimate.pluck(:id).sample
  end

  test 'should not get index, create, update or destroy as driver' do
    size_estimate_id = @random_se_id
    get api_v1_driver_size_estimates_path, headers: @authorized_headers
    assert_equal Message.unauthorized, json['message']

    post api_v1_driver_size_estimates_path,
         params: { size_estimate: { square_footage: 100.75, address_id: Address.last.id } }.to_json,
         headers: @authorized_headers
    assert_equal Message.unauthorized, json['message']

    patch api_v1_driver_size_estimate_path(id: size_estimate_id),
          params: { size_estimate: { square_footage: 112.75 } }.to_json,
          headers: @authorized_headers
    assert_equal Message.unauthorized, json['message']

    se_count = SizeEstimate.count
    delete api_v1_driver_size_estimate_path(@random_se_id), headers: @authorized_headers
    assert_equal Message.unauthorized, json['message']
    assert_equal SizeEstimate.count, se_count
  end

  test 'should get show as driver' do
    get api_v1_driver_size_estimate_path(@random_se_id), headers: @authorized_headers
    assert_response :success
    assert_equal @random_se_id, json['data']['id'].to_i
  end
end
