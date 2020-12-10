# frozen_string_literal: true

class PlowSerializer
  include FastJsonapi::ObjectSerializer
  attributes :licence_plate, :year, :color, :make, :model, :user_id
end
