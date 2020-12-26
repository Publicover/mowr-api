# frozen_string_literal: true

class SnowAccumulationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :inches
end
