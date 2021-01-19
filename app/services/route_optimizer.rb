# frozen_string_literal: true

class RouteOptimizer
  BASE_URL = 'http://router.project-osrm.org'
  SERVICE = 'trip'
  VERSION = 'v1'
  PROFILE = 'driving'
  SOURCE = '?source=first'

  class << self
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
  end
end
