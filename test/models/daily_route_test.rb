require 'test_helper'

class DailyRouteTest < ActiveSupport::TestCase
  setup do
    @base = base_locations(:one)
  end

  test 'can take an array' do
    route = DailyRoute.new(addresses_in_order: [1, 2, 4])
    assert route.save
  end
end
