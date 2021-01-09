class BaseLocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :line1, :line1, :city, :state, :zip, :latitude, :longitude
end
