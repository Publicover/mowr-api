# frozen_string_literal: true

class DailyRouteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :addresses_in_order
end
