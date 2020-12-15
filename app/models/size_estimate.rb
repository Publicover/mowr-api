# frozen_string_literal: true

class SizeEstimate < ApplicationRecord
  validates :address, presence: true
  belongs_to :address, inverse_of: :size_estimate

  delegate :user, to: :address
end
