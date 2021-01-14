# frozen_string_literal: true

class DailyRoute < ApplicationRecord
  scope :for_today, -> { where('created_at > ?', Time.zone.yesterday.end_of_day) }

  def addresses
    Address.find(addresses_in_order)
  end
end
