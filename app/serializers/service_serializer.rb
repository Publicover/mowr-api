# frozen_string_literal: true

class ServiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :price_per_driveway, :price_per_inch_of_snow
end
