ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'capybara/rails'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'rails/test_help'
require 'vcr'

require_relative '../test/graphql/support/users_mutation'
require_relative '../test/graphql/support/users_query'
require_relative '../test/graphql/support/auth_mutation'
require_relative '../test/controllers/api/v1/support/call_and_response_helpers'
require_relative '../test/controllers/api/v1/support/data_helpers'
require_relative '../test/controllers/api/v1/support/login_helpers'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.default_cassette_options = { :match_requests_on => [:query] }
end

class Minitest::Test
  include LoginHelpers
  include CallAndResponseHelpers
  include DataHelpers
  include UsersQuery
  include UsersMutation
  include AuthMutation
end
