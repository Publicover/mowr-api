# frozen_string_literal: true

class ServiceRequestSerializer
  include FastJsonapi::ObjectSerializer
  attributes :address_id, :approved, :recurring, :service_ids
end
