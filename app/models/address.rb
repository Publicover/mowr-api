# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :user, inverse_of: :addresses

  validates :line_1, :city, :state, :zip, presence: true
end
