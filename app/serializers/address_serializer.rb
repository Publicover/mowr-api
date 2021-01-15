# frozen_string_literal: true

class AddressSerializer
  include FastJsonapi::ObjectSerializer
  attributes :line1, :line2, :city, :state, :zip, :user_id, :name, :latitude, :longitude, :driveway

  belongs_to :user
  has_one :size_estimate
  has_one :service_request
  has_one :early_bird
  has_many :service_deliveries
end
