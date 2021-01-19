require 'test_helper'

class RouteOptimizerTest < ActionDispatch::IntegrationTest
  setup do
    @base_location = base_locations(:one)
  end

  test 'fixtures are in working order' do
    assert_not_nil Address.count
  end

  test 'has base_call_url' do
    assert RouteOptimizer.base_call_url.is_a?(String)
  end

  test 'can retrieve base location coords' do
    coords = RouteOptimizer.base_location_coords
    split_coords = coords.split(',')
    assert coords.is_a?(String)
    # This is dumb, but I need to do an operation with the coordinates so it
    #   doesn't come out of the db in exponent format
    assert_equal (@base_location.longitude * 1).to_s, split_coords[0]
    assert_equal (@base_location.latitude * 1).to_s, split_coords[1].delete_suffix(';')
  end

  test 'can stringify Address coords by scope' do
    early_coords = RouteOptimizer.string_of_coords(Address.with_early_birds)
    unscoped_coords = RouteOptimizer.string_of_coords(Address.without_early_birds)
    all_coords = RouteOptimizer.string_of_coords(Address)
    refute_equal early_coords.size, unscoped_coords.size
    assert all_coords.size > early_coords.size
    assert all_coords.size > unscoped_coords.size
  end

  test 'can perform with early_birds scope' do
    response = VCR.use_cassette('daily route test early birds scope', allow_playback_repeats: true) do
      RouteOptimizer.perform_with_early_birds
    end
    assert_equal response['code'], 'Ok'
  end

  test 'can perform with addresses without early_birds' do
    starting_point_coords = RouteOptimizer.base_location_coords
    response = VCR.use_cassette('daily route test early birds scope', allow_playback_repeats: true) do
      RouteOptimizer.perform_without_early_birds(starting_point_coords)
    end
    assert_equal response['code'], 'Ok'
  end

  test 'can retrieve Address ids used in call by scope' do
    early_bird_ids = CalculateDailyRoute.new.addresses_in_call(Address.with_early_birds)
    unscoped_ids = CalculateDailyRoute.new.addresses_in_call(Address.without_early_birds)
    assert_not_nil early_bird_ids
    assert_not_nil unscoped_ids
    assert_equal Address.with_current_service_requests.count, early_bird_ids.count + unscoped_ids.count
  end

end
