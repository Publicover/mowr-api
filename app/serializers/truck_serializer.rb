# frozen_string_literal: true

class TruckSerializer
  include FastJsonapi::ObjectSerializer
  attributes :licence_plate, :year, :color, :make, :model, :user_id
end
