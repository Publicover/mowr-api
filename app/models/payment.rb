# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :user, inverse_of: :payments
end
