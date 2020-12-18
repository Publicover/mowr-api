# frozen_string_literal: true

class ServiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :price_per_sq_ft, :price_per_inch_of_snow, :price_per_season
end
