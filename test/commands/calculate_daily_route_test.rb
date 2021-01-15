require 'test_helper'

class CalculateDailyRouteTest < ActionDispatch::IntegrationTest
  setup do
    @base_location = base_locations(:one)
  end

  test 'VCR is in working order' do
    assert_not_nil Address.count
  end

  test 'has base_call_url' do
    assert CalculateDailyRoute.new.base_call_url.is_a?(String)
  end

  test 'can retrieve base location coords' do
    coords = CalculateDailyRoute.new.base_location_coords
    split_coords = coords.split(',')
    assert coords.is_a?(String)
    # This is dumb, but I need to do an operation with the coordinates so it
    #   doesn't come out of the db in exponent format
    assert_equal (@base_location.longitude * 1).to_s, split_coords[0]
    assert_equal (@base_location.latitude * 1).to_s, split_coords[1].delete_suffix(';')
  end

  test 'can stringify Address coords by scope' do
    early_coords = CalculateDailyRoute.new.string_of_coords(Address.with_early_birds)
    unscoped_coords = CalculateDailyRoute.new.string_of_coords(Address.without_early_birds)
    all_coords = CalculateDailyRoute.new.string_of_coords(Address)
    refute_equal early_coords.size, unscoped_coords.size
    assert all_coords.size > early_coords.size
    assert all_coords.size > unscoped_coords.size
  end

  test 'can perform with early_birds scope' do
    response = VCR.use_cassette('daily route test early birds scope', allow_playback_repeats: true) do
      CalculateDailyRoute.new.perform_with_early_birds
    end
    assert_equal response['code'], 'Ok'
  end

  test 'can perform with addresses without early_birds' do
    starting_point_coords = CalculateDailyRoute.new.base_location_coords
    response = VCR.use_cassette('daily route test early birds scope', allow_playback_repeats: true) do
      CalculateDailyRoute.new.perform_without_early_birds(starting_point_coords)
    end
    assert_equal response['code'], 'Ok'
  end

  test 'can retrieve Address ids used in call by scope' do
    # TODO: probably need to swap out for scope with curret service deliveries
    early_bird_ids = CalculateDailyRoute.new.addresses_in_call(Address.with_early_birds)
    unscoped_ids = CalculateDailyRoute.new.addresses_in_call(Address.without_early_birds)
    assert_not_nil early_bird_ids
    assert_not_nil unscoped_ids
    assert_equal Address.with_current_service_requests.count, early_bird_ids.count + unscoped_ids.count
  end

  test 'can retrieve array of Address index returned in call' do
    response = VCR.use_cassette('daily route test early birds scope', allow_playback_repeats: true) do
      CalculateDailyRoute.new.perform_with_early_birds
    end
    indices = CalculateDailyRoute.new.called_addresses_indices(response)
    assert indices.is_a?(Array)
  end

  test 'can sort original Address array according to returned indices' do
    early_bird_ids = CalculateDailyRoute.new.addresses_in_call(Address.with_early_birds)
    response = VCR.use_cassette('daily route test early birds scope', allow_playback_repeats: true) do
      CalculateDailyRoute.new.perform_with_early_birds
    end
    indices = CalculateDailyRoute.new.called_addresses_indices(response)
    addresses_in_order = CalculateDailyRoute.new.return_addresses_in_order(Address.with_early_birds, response)
    assert (early_bird_ids - addresses_in_order).empty?
    assert (addresses_in_order - early_bird_ids).empty?
  end

  test 'can retrieve last address used in call' do
    early_bird_ids = CalculateDailyRoute.new.addresses_in_call(Address.with_early_birds)
    response = VCR.use_cassette('daily route test early birds scope', allow_playback_repeats: true) do
      CalculateDailyRoute.new.perform_with_early_birds
    end
    addresses_in_order = CalculateDailyRoute.new.return_addresses_in_order(Address.with_early_birds, response)
    last_address = CalculateDailyRoute.new.retrieve_last_called_address(Address.with_early_birds, response)
    assert early_bird_ids.include?(last_address.id.to_s)
    assert addresses_in_order.include?(last_address.id.to_s)
  end

  test 'can do full call without early_birds scope' do
    EarlyBird.destroy_all

    response = VCR.use_cassette('daily route full call no early birds') do
      CalculateDailyRoute.new.call
    end
    assert ServiceRequest.without_early_birds.count, response['waypoints'].size
  end

  test 'can do full call when all addresses have early birds' do
    ServiceRequest.without_early_birds.destroy_all
    refute ServiceRequest.with_early_birds.count.zero?

    response = VCR.use_cassette('daily route full call all early birds') do
      CalculateDailyRoute.new.call
    end
    assert ServiceRequest.with_early_birds.count, response['waypoints'].size
  end

  test 'calling command returns calls with each scope' do
    response = VCR.use_cassette('daily route full call') do
      CalculateDailyRoute.new.call
    end
    full_call_ids = response.map { |id| id.to_i }
    early_bird_ids = Address.with_early_birds.pluck(:id)
    unscoped_ids = Address.without_early_birds.pluck(:id)
    assert (full_call_ids - early_bird_ids - unscoped_ids).empty?
  end
end
