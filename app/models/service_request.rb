# frozen_string_literal: true

class ServiceRequest < ApplicationRecord
  validates :address, presence: true

  belongs_to :address, inverse_of: :service_request

  has_one :user, through: :address

  enum status: {
    open: 0,
    confirmed: 1
  }
end
