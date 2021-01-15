ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'capybara/rails'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'rails/test_help'
require 'vcr'

require_relative '../test/graphql/support/graphql_requirements'
require_relative '../test/api_requirements'

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
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.default_cassette_options = { :match_requests_on => [:query] }
end

class Minitest::Test
  include ApiRequirements
  include GraphqlRequirements
end
