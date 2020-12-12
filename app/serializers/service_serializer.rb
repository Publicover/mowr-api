# frozen_string_literal: true

class ServiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :price_per_quarter_hour
end
