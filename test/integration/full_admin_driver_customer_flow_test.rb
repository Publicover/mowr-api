require 'test_helper'

class FullAdminDriverCustomerFlow < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:one)
    @driver = users(:two)
    @headers = { "Content-Type" => "application/json" }
  end

  test 'flow from user signup to service delivery' do
    # check to make sure no emails are queued
    assert_enqueued_emails 0

    # customer signs up
    assert_difference('User.count') do
      post signup_path, params: signup_params, headers: signup_headers
    end
    assert_response :created

    # FE catches auth_token
    @customer = User.last
    customer_headers = signup_headers.merge('Authorization' => "#{json['auth_token']}")

    # customer gives address info
    assert_difference('Address.count') do
      post api_v1_customer_addresses_path, params: address_params, headers: customer_headers
    end
    assert_response :success

    # capture the new address
    @address = @customer.addresses.last
    assert @address.reload.latitude
    assert @address.reload.longitude

    # customer gives size estimate
    assert_difference('SizeEstimate.count') do
      post api_v1_customer_size_estimates_path, params: size_params, headers: customer_headers
    end
    assert_response :success

    # customer gives service request
    assert_difference('ServiceRequest.count') do
      post api_v1_customer_service_requests_path, params: request_params, headers: customer_headers
    end
    assert_response :success
    assert_not_nil ServiceRequest.last.service_ids

    # customer receives an email
    assert_enqueued_emails 1

    # admin confirms size and services
    login_as_admin

    # we can fudge the address since the flow includes showing the admin the address
    # and service request before creating this service_delivery
    assert_difference('ServiceDelivery.count') do
      post api_v1_admin_service_deliveries_path,
           params: service_delivery_params,
           headers: @admin_headers
    end
    assert_response :success

    # deliveries are populated by backend: see below
    # delvieries are run through OSRM
      # early bird service starts before 8 am and starts the day
      # everyone else goes after them
    # drivers and admins have access to the routes
    # customers can pay through stripe
  end



  # BACKEND:
  #   check the snow forecast at midnight
  #   if it is supposed to snow, generate new table
  #     create all service deliveries, leaving total cost nil
  #     run the snow forcast again at 5AM, checking accumulation
  #       if no accumulation, wipe all from day
  #       if some accumulation, calculate all service delivery total_cost



  # HERE BE DATA!

  def signup_params
    {
      email: 'happy@customer.com', f_name: 'Happy', l_name: 'Customer',
      password: 'password', password_confirmation: 'password',
      role: :customer, phone: Faker::PhoneNumber.phone_number
    }.to_json
  end

  def signup_headers
    {
      'Content-Type' => 'application/json',
      'Accepts' => 'application/json'
    }
  end

  def address_params
    { address: {
      line_1: '1714 W 19th St',
      city: 'Ashtabula',
      state: 'Ohio',
      zip: '44004',
      name: 'Convenient Mart',
      user_id: @customer.id,
      driveway: :medium
      }
    }.to_json
  end

  def size_params
    { size_estimate: {
      address_id: @address.id,
      square_footage: 250.0
      }
    }.to_json
  end

  def request_params
    { service_request: {
      address_id: @address.id,
      service_ids: Service.pluck(:id)
      }
    }.to_json
  end

  def service_delivery_params
    { service_delivery: { address_id: ServiceRequest.last.address.id } }.to_json
  end
end
