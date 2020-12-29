# frozen_string_literal: true

class CalculateDailyRoute
  BASE_URL = 'http://router.project-osrm.org'
  SERVICE = 'trip'
  VERSION = 'v1'
  PROFILE = 'driving'
  SOURCE = '?source=first'

  def base_call_url
    "#{BASE_URL}/#{SERVICE}/#{VERSION}/#{PROFILE}"
  end

  def base_location_coords
    "#{BaseLocation.first.longitude},#{BaseLocation.first.latitude};"
  end

  def string_of_coords(scope)
    coords = scope.all.each_with_object([]) do |address, memo|
      memo << "#{address.longitude},#{address.latitude};"
    end
    coords.join.delete_suffix(';')
  end

  def perform_with_early_birds
    HTTParty.get("#{base_call_url}/#{base_location_coords}#{string_of_coords(Address.with_early_birds)}#{SOURCE}")
  end

  def perform_without_early_birds(starting_point_coords)
    HTTParty.get("#{base_call_url}/#{starting_point_coords}#{string_of_coords(Address.without_early_birds)}#{SOURCE}")
  end

  def perform_full_call
    early_response = perform_with_early_birds
    early_bird_ids = return_addresses_in_order(Address.with_early_birds, early_response)
    last_address = retrieve_last_called_address(Address.with_early_birds, early_response)
    last_address_coords = "#{last_address.longitude},#{last_address.latitude};"
    unscoped_response = perform_without_early_birds(last_address_coords)
    unscoped_ids = return_addresses_in_order(Address.without_early_birds, unscoped_response)
    early_bird_ids + unscoped_ids
  end

  def call
    return perform_with_early_birds if ServiceRequest.without_early_birds.empty?
    return perform_without_early_birds(base_location_coords) if ServiceRequest.with_early_birds.empty?

    perform_full_call
  end

  def addresses_in_call(scope)
    scope.all.each_with_object([]) do |address, memo|
      memo << address.id.to_s
    end
  end

  def called_addresses_indices(response)
    response['waypoints'].each_with_object([]) do |json, memo|
      memo << json['waypoint_index']
    end
  end

  def return_addresses_in_order(scope, response)
    address_ids = addresses_in_call(scope)
    addresses_order = called_addresses_indices(response)
    addresses_order.each_with_object([]) do |index, memo|
      memo << address_ids[index]
      memo.delete(nil)
    end
  end

  def retrieve_last_called_address(scope, response)
    Address.find(return_addresses_in_order(scope, response)[-1])
  end
end
