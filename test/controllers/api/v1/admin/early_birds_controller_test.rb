require 'test_helper'

class Api::V1::Admin::EarlyBirdsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login_as_admin
    @early_bird = EarlyBird.all.sample
  end

  test 'should see entire index as admin' do
    get api_v1_admin_early_birds_path, headers: @admin_headers
    assert_response :success
    assert_equal EarlyBird.count, json['data'].size
  end

  test 'should see any record as admin' do
    get api_v1_admin_early_bird_path(@early_bird), headers: @admin_headers
    assert_response :success
    assert_equal @early_bird.id, json['data']['id'].to_i
  end

  test 'should create early bird as admin' do
    customer = User.customer.sample
    assert_difference('EarlyBird.count') do
      post api_v1_admin_early_birds_path,
           params: { early_bird: { address_id: customer.addresses.sample.id, priority: :active } }.to_json,
           headers: @admin_headers
    end
    assert_response :success
  end

  test 'should update any early bird as admin' do
    patch api_v1_admin_early_bird_path(@early_bird),
          params: { early_bird: { priority: :cancelled } }.to_json,
          headers: @admin_headers
    assert_response :success
    assert_equal 'cancelled', @early_bird.reload.priority
  end

  test 'should delete any early bird as admin' do
    assert_difference('EarlyBird.count', -1) do
      delete api_v1_admin_early_bird_path(@early_bird), headers: @admin_headers
    end
  end
end
