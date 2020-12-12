# frozen_string_literal: true

class ServiceRequest < ApplicationRecord
  belongs_to :address, inverse_of: :service_request
end
