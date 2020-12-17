# frozen_string_literal: true

class SizeEstimate < ApplicationRecord
  after_save :confirm_size_estimate

  validates :address, presence: true
  belongs_to :address, inverse_of: :size_estimate

  has_one :user, through: :address

  delegate :user, to: :address

  enum status: {
    open: 0,
    confirmed: 1
  }

  def confirm_size_estimate
    address.update(estimate_complete: true)
  end

  def change_to_confirmed
    confirmed!
  end
end
