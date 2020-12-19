# frozen_string_literal: true

class AddressSerializer
  include FastJsonapi::ObjectSerializer
  attributes :line_1, :line_2, :city, :state, :zip, :user_id, :name, :latitude, :longitude, :driveway

  belongs_to :user
  has_one :size_estimate
  has_one :service_request
  has_one :service_delivery
  has_one :early_bird
end
