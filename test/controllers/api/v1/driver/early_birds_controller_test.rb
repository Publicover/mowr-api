require 'test_helper'

class Api::V1::Driver::EarlyBirdsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login_as_driver
    @early_bird = EarlyBird.all.sample
  end

  test 'should get entire index as driver' do
    get api_v1_driver_early_birds_path, headers: @driver_headers
    assert_response :success
    assert_equal EarlyBird.count, json['data'].size
  end

  test 'should get record as driver' do
    get api_v1_driver_early_bird_path(@early_bird), headers: @driver_headers
    assert_response :success
    assert_equal @early_bird.id, json['data']['id'].to_i
  end
end
