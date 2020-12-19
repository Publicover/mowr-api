ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'capybara/rails'
# require 'database_cleaner'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'vcr'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def json
    JSON.parse(response.body)
  end

  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  def valid_headers(user_id)
    {
      "Authorization" => token_generator(user_id),
      "Content-Type" => "application/json"
    }
  end

  def invalid_headers
    {
      "Authorization" => nil,
      "Content-Type" => "application/json"
    }
  end

  def unauthorized_headers
    {
      "Content-Type" => "application/json",
      "Accepts" => "application/json"
    }
  end
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


module LoginHelpers
  def login_as_admin
    @admin = users(:one)
    @valid_creds = { email: @admin.email, password: 'password' }.to_json
    post auth_login_path, headers: unauthorized_headers, params: @valid_creds
    @admin_headers = unauthorized_headers.merge('Authorization' => "#{json['auth_token']}")
  end

  def login_as_driver
    @driver = users(:two)
    @valid_creds = { email: @driver.email, password: 'password' }.to_json
    post auth_login_path, headers: unauthorized_headers, params: @valid_creds
    @driver_headers = unauthorized_headers.merge('Authorization' => "#{json['auth_token']}")
  end

  def login_as_customer
    @customer = users(:three)
    @valid_creds = { email: @customer.email, password: 'password' }.to_json
    post auth_login_path, headers: unauthorized_headers, params: @valid_creds
    @customer_headers = unauthorized_headers.merge('Authorization' => "#{json['auth_token']}")
  end
end

module CreateData
  def populate_size_estimates
    5.times do
      address = Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                                state: Faker::Address.state, zip: Faker::Address.zip_code,
                                user_id: [User.first.id, User.last.id].sample,
                                latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                                name: Faker::Company.name, driveway: [:small, :medium, :large].sample)
      SizeEstimate.create!(square_footage: Faker::Number.between(from: 30.0, to: 100.0).round(2), address_id: address.id)
    end
    Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                    state: Faker::Address.state, zip: Faker::Address.zip_code,
                    user_id: [User.first.id, User.last.id].sample,
                    latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                    name: Faker::Company.name, driveway: [:small, :medium, :large].sample)
  end

  def populate_blank_address
    @address = Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                    state: Faker::Address.state, zip: Faker::Address.zip_code,
                    user_id: [User.first.id, User.last.id].sample,
                    latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                    name: Faker::Company.name, driveway: [:small, :medium, :large].sample)
  end

  def fill_request_service_ids
    ids = Service.pluck(:id)
    ServiceRequest.all.each { |record| record.update(service_ids: ids)}
  end

  def populate_service_request
    @address = populate_blank_address
    @service_request = ServiceRequest.create(address_id: @address.id, status: :pending)
    @size_estimate = SizeEstimate.create(address_id: @address.id, status: :pending)
    fill_request_service_ids
  end
end

class Minitest::Test
  # include AroundEachTest
  include LoginHelpers
  include CreateData
end
