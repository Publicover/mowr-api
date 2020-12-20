# frozen_string_literal: true

class CurrentSnowfall
  BASE_URL = 'https://api.weatherbit.io/v2.0/current'
  KEY = ENV['WEATHERBIT_KEY']
  UNITS = 'I'

  def postal_code(zip)
    "&postal_code=#{zip}&country=US"
  end

  def perform(zip)
    HTTParty.get("#{BASE_URL}?#{postal_code(zip)}&key=#{KEY}")
  end

  def snowfall(zip)
    response = perform(zip)
    response['data'][0]['snow']
  end
end
