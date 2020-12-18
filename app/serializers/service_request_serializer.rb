# frozen_string_literal: true

class ServiceRequestSerializer
  include FastJsonapi::ObjectSerializer
  attributes :address_id, :approved, :service_ids

  belongs_to :address
end
