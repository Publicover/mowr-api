ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'capybara/rails'
# require 'database_cleaner'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'rails/test_help'
require 'vcr'
require 'webmock/minitest'

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
  def populate_services
    Service.create!(name: 'Driveway Plow', price_per_inch_of_snow: 5,
                    price_per_driveway: [25, 40, 60])
    Service.create!(name: 'De-Icing', price_per_inch_of_snow: 5,
                    price_per_driveway: [10, 15, 20])
    Service.create!(name: 'Snowblower Rental', price_per_inch_of_snow: 5,
                    price_per_driveway: [25, 35, 45])
  end

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

  def populate_addresses_with_early_birds
    populate_services
    @user = users(:three)

    VCR.use_cassette('test helper early birds big list', allow_playback_repeats: true) do
      hil_mak = Address.create!(line_1: '449 Lake Ave', city: 'Ashtabula',
                                state: 'OH', zip: '44004', name: 'Hil-Mak Seafood', user_id: @user.id,
                                driveway: [:small, :medium, :large].sample)
                                # lat: 41.89705, long: -80.80487
      EarlyBird.create!(priority: :active, address_id: hil_mak.id)
      ServiceRequest.create!(address_id: hil_mak.id, service_ids: Service.pluck(:id), status: :confirmed)
      SizeEstimate.create(address_id: hil_mak.id, square_footage: rand(500..1500))

      cloven = Address.create!(line_1: '1308 Bridge St', city: 'Ashtabula',
                               state: 'OH', zip: '44004', name: 'Cloven Hoof Brewery', user_id: @user.id,
                               driveway: [:small, :medium, :large].sample)
                               # lat: 41.898124, long: -80.802088
      EarlyBird.create!(priority: :active, address_id: cloven.id)
      ServiceRequest.create!(address_id: cloven.id, service_ids: Service.pluck(:id), status: :confirmed)
      SizeEstimate.create(address_id: cloven.id, square_footage: rand(500..1500))

      morrell = Address.create!(line_1: '1040 E 6th St', city: 'Ashtabula',
                                state: 'OH', zip: '44004', name: 'Morrell Music', user_id: @user.id,
                                driveway: [:small, :medium, :large].sample)
                               # lat: 41.900144, long: -80.787492
      EarlyBird.create!(priority: :active, address_id: morrell.id)
      ServiceRequest.create!(address_id: morrell.id, service_ids: Service.pluck(:id), status: :confirmed)
      SizeEstimate.create(address_id: morrell.id, square_footage: rand(500..1500))

      dollar = Address.create!(line_1: '1708 W Prospect Rd', city: 'Ashtabula',
                               state: 'OH', zip: '44004', name: 'Dollar General', user_id: @user.id,
                               driveway: [:small, :medium, :large].sample)
      EarlyBird.create!(priority: :active, address_id: dollar.id)
      ServiceRequest.create!(address_id: dollar.id, service_ids: Service.pluck(:id), status: :confirmed)
      SizeEstimate.create(address_id: dollar.id, square_footage: rand(500..1500))

      lake_shore = Address.create!(line_1: '2234 Lake Ave', city: 'Ashtabula',
                                   state: 'OH', zip: '44004', name: 'Lake Shore Lanes', user_id: @user.id,
                                   driveway: [:small, :medium, :large].sample)
      EarlyBird.create!(priority: :active, address_id: lake_shore.id)
      ServiceRequest.create!(address_id: lake_shore.id, service_ids: Service.pluck(:id), status: :confirmed)
      SizeEstimate.create(address_id: lake_shore.id, square_footage: rand(500..1500))

      capos = Address.create!(line_1: '1205 Lake Ave', city: 'Ashtabula',
                              state: 'OH', zip: '44004', name: "Capo's Pizza", user_id: @user.id,
                              driveway: [:small, :medium, :large].sample)
      EarlyBird.create!(priority: :active, address_id: capos.id)
      ServiceRequest.create!(address_id: capos.id, service_ids: Service.pluck(:id), status: :confirmed)
      SizeEstimate.create(address_id: capos.id, square_footage: rand(500..1500))

      main_moon = Address.create!(line_1: '1030 Lake Ave', city: 'Ashtabula',
                                  state: 'OH', zip: '44004', name: 'Main Moon', user_id: @user.id,
                                  driveway: [:small, :medium, :large].sample)
      EarlyBird.create!(priority: :active, address_id: main_moon.id)
      ServiceRequest.create!(address_id: main_moon.id, service_ids: Service.pluck(:id), status: :confirmed)
      SizeEstimate.create(address_id: main_moon.id, square_footage: rand(500..1500))

      lakeway = Address.create!(line_1: '729 Lake Ave', city: 'Ashtabula',
                                state: 'OH', zip: '44004', name: 'Lakeway Restaurant', user_id: @user.id,
                                driveway: [:small, :medium, :large].sample)
      ServiceRequest.create!(address_id: lakeway.id, service_ids: Service.pluck(:id), status: :confirmed)
      SizeEstimate.create(address_id: lakeway.id, square_footage: rand(500..1500))

      hospice = Address.create!(line_1: '1166 Lake Ave', city: 'Ashtabula',
                                state: 'OH', zip: '44004', name: 'Hospice', user_id: @user.id,
                                driveway: [:small, :medium, :large].sample)
      ServiceRequest.create!(address_id: hospice.id, service_ids: Service.pluck(:id), status: :confirmed)
      SizeEstimate.create(address_id: hospice.id, square_footage: rand(500..1500))

      goodwill = Address.create!(line_1: '621 Goodwill Dr', city: 'Ashtabula',
                                 state: 'OH', zip: '44004', name: 'Goodwill', user_id: @user.id,
                                 driveway: [:small, :medium, :large].sample)
      ServiceRequest.create!(address_id: goodwill.id, service_ids: Service.pluck(:id), status: :confirmed)
      SizeEstimate.create(address_id: goodwill.id, square_footage: rand(500..1500))

      crows = Address.create!(line_1: '1257 Harmon Rd', city: 'Ashtabula',
                              state: 'OH', zip: '44004', name: "Crow's Nest", user_id: @user.id,
                              driveway: [:small, :medium, :large].sample)
      ServiceRequest.create!(address_id: crows.id, service_ids: Service.pluck(:id), status: :confirmed)
      SizeEstimate.create(address_id: crows.id, square_footage: rand(500..1500))

      cvs = Address.create!(line_1: '1819 E Prospect Rd', city: 'Ashtabula',
                            state: 'OH', zip: '44004', name: 'CVS', user_id: @user.id,
                            driveway: [:small, :medium, :large].sample)
      ServiceRequest.create!(address_id: cvs.id, service_ids: Service.pluck(:id), status: :confirmed)
      SizeEstimate.create(address_id: cvs.id, square_footage: rand(500..1500))
    end
  end

  def populate_daily_routes_data
    populate_services

    hil_mak = Address.create!(line_1: '449 Lake Ave', city: 'Ashtabula',
                              state: 'OH', zip: '44004', name: 'Hil-Mak Seafood', user_id: User.last.id,
                              driveway: [:small, :medium, :large].sample)
    ServiceRequest.create(address_id: hil_mak.id, service_ids: Service.pluck(:id), status: :confirmed)
    SizeEstimate.create(address_id: hil_mak.id, square_footage: 300, )

    cloven = Address.create!(line_1: '1308 Bridge St', city: 'Ashtabula',
                             state: 'OH', zip: '44004', name: 'Cloven Hoof Brewery', user_id: User.last.id,
                             driveway: [:small, :medium, :large].sample)
    ServiceRequest.create(address_id: cloven.id, service_ids: Service.pluck(:id), status: :confirmed)
    SizeEstimate.create(address_id: cloven.id, square_footage: 300, )

    morrell = Address.create!(line_1: '1040 E 6th St', city: 'Ashtabula',
                              state: 'OH', zip: '44004', name: 'Morrell Music', user_id: User.last.id,
                              driveway: [:small, :medium, :large].sample)
    ServiceRequest.create(address_id: morrell.id, service_ids: Service.pluck(:id), status: :confirmed)
    SizeEstimate.create(address_id: morrell.id, square_footage: 300, )
  end
end

class Minitest::Test
  include LoginHelpers
  include CreateData
end
