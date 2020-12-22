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

  def string_of_coords
    coords = ServiceDelivery.all.each_with_object([]) do |delivery, memo|
      memo << "#{delivery.address.longitude},#{delivery.address.latitude};"
    end
    coords.join.delete_suffix(';')
  end

  def perform
    HTTParty.get("#{base_call_url}/#{base_location_coords}#{string_of_coords}#{SOURCE}")
  end

end
