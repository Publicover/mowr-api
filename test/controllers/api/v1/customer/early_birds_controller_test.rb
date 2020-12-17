require 'test_helper'

class Api::V1::Admin::EarlyBirdsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login_as_customer
    @early_bird = @customer.early_birds.sample
  end

  test 'should see own records as customer' do
    get api_v1_customer_early_birds_path, headers: @customer_headers
    assert_response :success
    assert_equal EarlyBird.joins(:address).where( addresses: { user_id: @customer.id }).count, json['data'].size
  end

  test 'should see own record as customer' do
    get api_v1_customer_early_bird_path(@early_bird), headers: @customer_headers
    assert_response :success
    assert_equal @early_bird.id, json['data']['id'].to_i
  end

  test 'should create early bird as customer' do
    assert_difference('EarlyBird.count') do
      post api_v1_customer_early_birds_path,
           params: { early_bird: { address_id: @customer.addresses.sample.id, priority: :active } }.to_json,
           headers: @customer_headers
    end
    assert_response :success
  end

  test 'should update own early bird as customer' do
    patch api_v1_customer_early_bird_path(@early_bird),
          params: { early_bird: { priority: :cancelled } }.to_json,
          headers: @customer_headers
    assert_response :success
    assert_equal 'cancelled', @early_bird.reload.priority
  end

  test 'should delete own early bird as customer' do
    assert_difference('EarlyBird.count', -1) do
      delete api_v1_customer_early_bird_path(@early_bird), headers: @customer_headers
    end
  end
end
