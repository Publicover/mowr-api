# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :user, inverse_of: :addresses

  has_one :size_estimate, inverse_of: :address, dependent: :destroy
  has_one :service_request, inverse_of: :address, dependent: :destroy

  validates :line_1, :city, :state, :zip, presence: true
end
