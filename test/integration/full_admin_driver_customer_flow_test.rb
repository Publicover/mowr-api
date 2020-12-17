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
    # TODO: geocoding

    # capture the new address
    @address = @customer.addresses.last

    # customer gives size estimate
    assert_difference('SizeEstimate.count') do
      post api_v1_customer_size_estimates_path, params: size_params, headers: customer_headers
    end
    assert SizeEstimate.last.address.reload.estimate_complete

    # customer gives service request
    assert_difference('ServiceRequest.count') do
      post api_v1_customer_service_requests_path, params: request_params, headers: customer_headers
    end
    assert_not_nil ServiceRequest.last.service_ids

    # customer receives an email
    assert_enqueued_emails 1

    # driver confirms size and services
    login_as_driver
    patch api_v1_driver_address_path(@address), params: confirm_params, headers: @driver_headers
    assert_response :success
    assert @address.size_estimate.confirmed?


    # TODO: when admin confirms service request,
    #       flip an enum in service request to reflect that
    #         enum status: { open: 0, confirmed: 1 }


    # calculate square footage x rate x rate for depth of snow
    #   A good rule of thumb for any removal project over six inches is to add $30
    #   per additional half-foot of snow. So, removal of six inches might start at
    #   $85, while removal of 18 inches would cost $145. Many contractors require a
    #   deposit, usually around $50 at the beginning of the season.

    # admin confirms service and price
    # login_as_admin
    # post api_v1_admin_confirmed_services_path, params:

    # deliveries are populated by admin
      # ApprovedService?
    # delvieries are run through OSRM
      # early bird service starts before 8 am and starts the day
      # everyone else goes after them
    # drivers and admins have access to the routes
    # customers can pay through stripe
  end

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
      user_id: @customer.id
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

  def confirm_params
    { address: {
      estimate_confirmed: true,
      actual_footage: 275.50
      }
    }.to_json
  end
end
