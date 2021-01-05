# frozen_string_literal: true

require_relative '../controllers/api/v1/support/call_and_response_helpers'
require_relative '../controllers/api/v1/support/data_helpers'
require_relative '../controllers/api/v1/support/login_helpers'

module ApiRequirements
  class Minitest::Test
    include CallAndResponseHelpers
    include DataHelpers
    include LoginHelpers
  end
end
