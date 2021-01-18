require 'test_helper'

class SizeEstimateTest < ActiveSupport::TestCase
  setup do
    @size_estimate = size_estimates(:one)
  end

  test 'should know address' do
    assert_not_nil @size_estimate.address
  end

  test 'should know user' do
    assert_equal users(:admin).id, @size_estimate.user.id
  end
end
