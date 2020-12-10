class ServiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :cost, :time_estimate
end
