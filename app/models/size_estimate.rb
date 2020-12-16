# frozen_string_literal: true

class SizeEstimate < ApplicationRecord
  after_save :confirm_size_estimate

  validates :address, presence: true
  belongs_to :address, inverse_of: :size_estimate

  delegate :user, to: :address

  def confirm_size_estimate
    address.update(estimate_complete: true)
  end
end
