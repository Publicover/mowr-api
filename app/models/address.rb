# frozen_string_literal: true

class Address < ApplicationRecord
  geocoded_by :compact_address
  after_validation :geocode, if: ->(obj) { obj.line_1.present? && obj.city.present? && obj.latitude.blank? }

  belongs_to :user, inverse_of: :addresses

  has_one :size_estimate, inverse_of: :address, dependent: :destroy
  has_one :service_request, inverse_of: :address, dependent: :destroy

  validates :line_1, :city, :state, :zip, presence: true

  def compact_address
    return if line_1.blank? || city.blank? || state.blank? || zip.blank?

    components = [line_1, city, state, zip]
    line_2.blank? ? components.compact.join(',') : components.insert(1, line_2).compact.join(',')
  end
end
