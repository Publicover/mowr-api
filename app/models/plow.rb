# frozen_string_literal: true

class Plow < ApplicationRecord
  belongs_to :user, inverse_of: :plow, optional: true

  validates :licence_plate, presence: true
end
