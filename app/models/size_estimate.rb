# frozen_string_literal: true

class SizeEstimate < ApplicationRecord
  belongs_to :address, inverse_of: :size_estimate

  has_one :user, through: :address

  validates :address, presence: true

  delegate :user, to: :address

  enum status: {
    pending: 0,
    confirmed: 1
  }

  def change_to_confirmed
    confirmed!
  end
end
