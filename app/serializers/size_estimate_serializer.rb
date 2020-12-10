# frozen_string_literal: true

class SizeEstimateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :square_footage, :address_id
end
