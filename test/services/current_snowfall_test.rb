# frozen_string_literal: true

require "test_helper"

class CurrentSnowfallTest < ActiveSupport::TestCase
  setup do
    @user = users(:three)
  end

  test 'should return current snowfall' do
    response = CurrentSnowfall.new.perform(@user.addresses.first.zip)
    assert_not_nil response
  end
end
