# frozen_string_literal: true

class BaseLocation < ApplicationRecord
  geocoded_by :compact_address
  after_validation :geocode, if: ->(obj) { obj.line1.present? && obj.city.present? && obj.latitude.blank? }

  validates :line1, :city, :state, :zip, presence: true

  def compact_address
    components = [line1, city, state, zip]
    line2.blank? ? components.compact.join(',') : components.insert(1, line2).compact.join(',')
  end
end
