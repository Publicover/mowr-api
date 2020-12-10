# frozen_string_literal: true

class AddressSerializer
  include FastJsonapi::ObjectSerializer
  attributes :line_1, :line_2, :city, :state, :zip, :user_id
  belongs_to :user
  has_one :size_estimate
end
