# frozen_string_literal: true

class Truck < ApplicationRecord
  belongs_to :user, inverse_of: :truck, optional: true

  validates :licence_plate, presence: true
end
