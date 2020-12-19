# frozen_string_literal: true

class ServiceRequestSerializer
  include FastJsonapi::ObjectSerializer
  attributes :address_id, :status, :service_ids

  belongs_to :address
end
