class ServiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :price_per_quarter_hour
end
