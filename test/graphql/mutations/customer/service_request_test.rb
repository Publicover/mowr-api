require 'test_helper'

class Mutations::ServiceRequestTest < ActionDispatch::IntegrationTest
  setup do
    populate_blank_address
  end

  test 'should create request for own address as customer' do
    create_blank_customer_address
    graphql_as_customer

    assert_difference('ServiceRequest.count') do
      post graphql_path, params: { query: create_service_request_helper(@customer_address.id) }
    end

    assert_response :success
  end

  test 'should not create request for another address as customer' do
    create_blank_admin_address
    graphql_as_customer

    post graphql_path, params: { query: create_service_request_helper(@admin_address.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should update own request as customer' do
    graphql_as_customer

    post graphql_path, params: { query: update_service_request_helper(service_requests(:two).id, services(:two).id) }

    assert_response :success
    assert_equal service_requests(:two).reload.service_ids, ["#{services(:two).id}".to_i]
  end

  test 'should not update another request as customer' do
    graphql_as_customer

    post graphql_path, params: { query: update_service_request_helper(service_requests(:one).id, services(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should destroy own servcie request as customer' do
    request = service_requests(:two)
    graphql_as_customer

    post graphql_path, params: { query: destroy_service_request_helper(request.id) }

    assert_response :success
    assert_equal Message.is_deleted(request), json['data']['destroyServiceRequest']['isDeleted']
  end

  test 'should not destroy another service request as customer' do
    request = service_requests(:one)
    graphql_as_customer

    post graphql_path, params: { query: destroy_service_request_helper(request.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  def create_blank_admin_address
    @admin_address = Address.create!(line1: Faker::Address.street_address, city: Faker::Address.city,
                     state: Faker::Address.state, zip: Faker::Address.zip_code,
                     user_id: users(:one).id, latitude: Faker::Address.latitude,
                     longitude: Faker::Address.longitude, name: Faker::Company.name,
                     driveway: [:small, :medium, :large].sample)
  end

  def create_blank_customer_address
    @customer_address = Address.create!(line1: Faker::Address.street_address, city: Faker::Address.city,
                    state: Faker::Address.state, zip: Faker::Address.zip_code,
                    user_id: users(:three).id, latitude: Faker::Address.latitude,
                    longitude: Faker::Address.longitude, name: Faker::Company.name,
                    driveway: [:small, :medium, :large].sample)
  end
end
