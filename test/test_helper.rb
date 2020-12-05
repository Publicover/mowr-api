ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'capybara/rails'
require 'minitest/autorun'
require 'minitest/pride'

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

  def login_as_new_admin
    @user = User.create(email: 'admin@mowr.com',
                        f_name: 'Jim',
                        l_name: 'Pub',
                        password: 'password',
                        password_confirmation: 'password',
                        role: :admin)
    @headers = valid_headers(@user.id).except('Authorization')
    @valid_creds = { email: @user.email, password: @user.password }.to_json
    @invalid_creds = { email: Faker::Internet.email, password: Faker::Internet.password }.to_json
    post auth_login_path, headers: @headers, params: @valid_creds
    @authorized_headers = {
      "Content-Type" => 'application/json',
      'Authorization' => "#{json['auth_token']}",
      'Accepts' => 'application/json'
    }

  end

  def login_as_new_driver
    @user = User.create(email: 'driver@mowr.com',
                        f_name: 'Jim',
                        l_name: 'Pub',
                        password: 'password',
                        password_confirmation: 'password',
                        role: :driver)
    @headers = valid_headers(@user.id).except('Authorization')
    @valid_creds = { email: @user.email, password: @user.password }.to_json
    @invalid_creds = { email: Faker::Internet.email, password: Faker::Internet.password }.to_json
    post auth_login_path, headers: @headers, params: @valid_creds
    @authorized_headers = {
      "Content-Type" => 'application/json',
      'Authorization' => "#{json['auth_token']}",
      'Accepts' => 'application/json'
    }
  end

  def login_as_new_customer
    @user = User.create(email: 'customer@mowr.com',
                        f_name: 'Jim',
                        l_name: 'Pub',
                        password: 'password',
                        password_confirmation: 'password',
                        role: :customer)
    @headers = valid_headers(@user.id).except('Authorization')
    @valid_creds = { email: @user.email, password: @user.password }.to_json
    @invalid_creds = { email: Faker::Internet.email, password: Faker::Internet.password }.to_json
    post auth_login_path, headers: @headers, params: @valid_creds
    @authorized_headers = {
      "Content-Type" => 'application/json',
      'Authorization' => "#{json['auth_token']}",
      'Accepts' => 'application/json'
    }
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end
