require 'test_helper'

class Mutations::ServiceRequestTest < ActionDispatch::IntegrationTest
  setup do
    populate_blank_address
  end

  test 'should create size estimate for own address as customer' do
    create_blank_customer_address
    graphql_as_customer

    assert_difference('SizeEstimate.count') do
      post graphql_path, params: { query: create_size_estimate_helper(@customer_address.id) }
    end
  end

  test 'should not create size estimate for another address as customer' do
    create_blank_admin_address
    graphql_as_customer

    post graphql_path, params: { query: create_size_estimate_helper(@admin_address.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should update own size estimate as customer' do
    graphql_as_customer

    post graphql_path, params: { query: update_size_estimate_helper(size_estimates(:two).id) }

    assert_response :success
    assert_equal size_estimates(:two).reload.square_footage, json['data']['updateSizeEstimate']['sizeEstimate']['squareFootage'].to_i
  end

  test 'should not update another size request as customer' do
    graphql_as_customer

    post graphql_path, params: { query: update_size_estimate_helper(size_estimates(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should destroy size estimate as customer' do
    estimate = size_estimates(:two)
    graphql_as_customer

    post graphql_path, params: { query: destroy_size_estimate_helper(estimate.id) }

    assert_response :success
    assert_equal Message.is_deleted(estimate), json['data']['destroySizeEstimate']['isDeleted']
  end

  test 'should not destroy another size estimate as customer' do
    estimate = size_estimates(:one)
    graphql_as_customer

    post graphql_path, params: { query: destroy_size_estimate_helper(estimate.id) }

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
