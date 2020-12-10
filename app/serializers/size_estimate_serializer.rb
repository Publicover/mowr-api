# frozen_string_literal: true

class SizeEstimateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :acreage, :address_id
end
