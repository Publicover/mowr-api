# frozen_string_literal: true

class EarlyBirdSerializer
  include FastJsonapi::ObjectSerializer
  attributes :address_id, :priority

  belongs_to :address
end
