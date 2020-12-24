# frozen_string_literal: true

class CalculateDailyRoute
  BASE_URL = 'http://router.project-osrm.org'
  SERVICE = 'trip'
  VERSION = 'v1'
  PROFILE = 'driving'
  SOURCE = '?source=first'

  # def initialize
  #   @scope = scope
  # end

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

  def call
    early_response = perform_with_early_birds
    early_bird_ids = calculate_addresses_in_order(early_response)
    last_address = Address.find(early_bird_ids[-1])
    last_address_coords = "#{last_address.latitude},#{last_address.longitude};"
    unscoped_response = perform_without_early_birds(last_address_coords)
    unscoped_ids = calculate_addresses_in_order(unscoped_response)
    daily_route = early_bird_ids + unscoped_ids
  end

  def addresses_in_call(scope)
    coords = scope.all.each_with_object([]) do |address, memo|
      memo << "#{address.id}"
    end
  end

  def called_addresses_indices(response)
    # binding.pry
    response['waypoints'].each_with_object([]) do |json, memo|
      # next if json['waypoint_index'] == 0
      puts "json #{json}"
      puts "json['waypoint_index'] #{json['waypoint_index']}"
      memo << json['waypoint_index']
    end
  end

  def return_addresses_in_order(scope, response)
    # puts "START"
    address_ids = addresses_in_call(scope)
    # puts "address_ids: #{address_ids}"
    addresses_order = called_addresses_indices(response)
    # puts "addresses_order #{addresses_order}"
    addresses_order.each_with_object([]) do |index, memo|
      puts "INDEX: #{index}"
      puts "index.class #{index.class}"
      next if index == 0
      memo << address_ids[index]
    end
  end

end


# http://router.project-osrm.org/trip/v1/driving/-80.824458,41.885948;-80.80487,41.89705;-80.787492,41.900144
#
# {
#   "code": "Ok",
#   "waypoints": [
#     {
#       "waypoint_index": 0,
#       "trips_index": 0,
#       "hint": "vxucicEbnIkMAAAAhAAAAE4AAAA3AAAAbQ8HQaQntkJHtllC8VUWQgwAAACEAAAATgAAADcAAABFSAAA8Lwu-_kgfwJ2ty77_CB_AgEADwB5Zdpn",
#       "distance": 116.387499,
#       "location": [
#         -80.823056,
#         41.885945
#       ],
#       "name": "Eleanor Drive"
#     },
#     {
#       "waypoint_index": 2,
#       "trips_index": 0,
#       "hint": "lSGciQUinIkoAAAALAAAAAAAAAAAAAAAc9zeQf6e8UEAAAAAAAAAACgAAAAsAAAAAAAAAAAAAABFSAAAYAQv-1RMfwL6Ay_7Wkx_AgAATwB5Zdpn",
#       "distance": 8.493713,
#       "location": [
#         -80.804768,
#         41.897044
#       ],
#       "name": "Lake Avenue"
#     },
#     {
#       "waypoint_index": 1,
#       "trips_index": 0,
#       "hint": "rSKcicMinIkHAAAAgAAAADMAAAAAAAAATXZEQVscQ0PaTZ1CAAAAAAcAAACAAAAAMwAAAAAAAABFSAAAz0cv-8JYfwLcRy_7cFh_AgEAfxB5Zdpn",
#       "distance": 9.171379,
#       "location": [
#         -80.787505,
#         41.900226
#       ],
#       "name": "East 6th Street"
#     }
#   ],
#   "trips": [
#     {
#       "legs": [
#         {
#           "steps": [],
#           "weight": 408.1,
#           "distance": 4333.5,
#           "summary": "",
#           "duration": 408.1
#         },
#         {
#           "steps": [],
#           "weight": 146.8,
#           "distance": 1645.3,
#           "summary": "",
#           "duration": 146.8
#         },
#         {
#           "steps": [],
#           "weight": 267.2,
#           "distance": 2744,
#           "summary": "",
#           "duration": 267.2
#         }
#       ],
#       "weight_name": "routability",
#       "geometry": "ezs~FbwhlNqDKEcF_J?}BhBcS?IaiBsY{BgMeYsFwP{CgE?cAbAyB|C}Vy@_[x@~Z}C|VcAxBA~@|CjErFvPbM`XBb@q@Ed[`CH`iBbS?lBeBnJCDbFpDJ",
#       "weight": 822.1,
#       "distance": 8722.8,
#       "duration": 822.1
#     }
#   ]
# }
