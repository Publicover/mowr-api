class BaseLocation < ApplicationRecord
  geocoded_by :compact_address
  after_validation :geocode, if: ->(obj) { obj.line_1.present? && obj.city.present? && obj.latitude.blank? }

  validates :line_1, :city, :state, :zip, presence: true

  def compact_address
    components = [line_1, city, state, zip]
    line_2.blank? ? components.compact.join(',') : components.insert(1, line_2).compact.join(',')
  end
end
