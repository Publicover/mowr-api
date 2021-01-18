# frozen_string_literal: true

require "test_helper"

class CurrentSnowfallTest < ActiveSupport::TestCase
  setup do
    @user = users(:customer)
  end

  test 'should return current weather conditions' do
    response = VCR.use_cassette('current snowfall perform') do
      CurrentSnowfall.new.perform(@user.addresses.first.zip)
    end
    parsed = JSON.parse(response.body)
    assert_not_nil parsed
  end

  test 'should return current snowfall' do
    response = VCR.use_cassette('current snowfall snowfall') do
      CurrentSnowfall.new.snowfall(@user.addresses.first.zip)
    end
    assert_not_nil response
  end
end
