require 'test_helper'

class CalculateDailyRouteTest < ActionDispatch::IntegrationTest
  setup do
    @base_location = base_locations(:one)
  end

  test 'can retrieve Address ids used in call by scope' do
    early_bird_ids = CalculateDailyRoute.new.addresses_in_call(Address.with_early_birds)
    unscoped_ids = CalculateDailyRoute.new.addresses_in_call(Address.without_early_birds)
    assert_not_nil early_bird_ids
    assert_not_nil unscoped_ids
    assert_equal Address.with_current_service_requests.count, early_bird_ids.count + unscoped_ids.count
  end

  test 'can retrieve array of Address index returned in call' do
    response = VCR.use_cassette('daily route test early birds scope', allow_playback_repeats: true) do
      RouteOptimizer.perform_with_early_birds
    end
    indices = CalculateDailyRoute.new.called_addresses_indices(response)
    assert indices.is_a?(Array)
  end

  test 'can sort original Address array according to returned indices' do
    early_bird_ids = CalculateDailyRoute.new.addresses_in_call(Address.with_early_birds)
    response = VCR.use_cassette('daily route test early birds scope', allow_playback_repeats: true) do
      RouteOptimizer.perform_with_early_birds
    end
    indices = CalculateDailyRoute.new.called_addresses_indices(response)
    addresses_in_order = CalculateDailyRoute.new.return_addresses_in_order(Address.with_early_birds, response)
    assert (early_bird_ids - addresses_in_order).empty?
    assert (addresses_in_order - early_bird_ids).empty?
  end

  test 'can retrieve last address used in call' do
    early_bird_ids = CalculateDailyRoute.new.addresses_in_call(Address.with_early_birds)
    response = VCR.use_cassette('daily route test early birds scope', allow_playback_repeats: true) do
      RouteOptimizer.perform_with_early_birds
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
    assert ServiceRequest.without_early_birds.count, DailyRoute.last.reload.addresses_in_order.size
  end

  test 'can do full call when all addresses have early birds' do
    ServiceRequest.without_early_birds.destroy_all
    refute ServiceRequest.with_early_birds.count.zero?

    response = VCR.use_cassette('daily route full call all early birds') do
      CalculateDailyRoute.new.call
    end
    assert ServiceRequest.with_early_birds.count, DailyRoute.last.reload.addresses_in_order.size
  end

  test 'calling command returns calls with each scope' do
    response = VCR.use_cassette('daily route full call') do
      CalculateDailyRoute.new.call
    end
    full_call_ids = DailyRoute.last.reload.addresses_in_order
    early_bird_ids = Address.with_early_birds.pluck(:id)
    unscoped_ids = Address.without_early_birds.pluck(:id)
    assert (full_call_ids - early_bird_ids - unscoped_ids).empty?
  end
end
