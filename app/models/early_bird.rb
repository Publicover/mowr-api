class EarlyBird < ApplicationRecord
  belongs_to :address, inverse_of: :early_bird

  has_one :user, through: :address

  enum priority: {
    active: 0,
    cancelled: 1
  }
end
