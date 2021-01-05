require 'test_helper'

class Mutations::EarlyBirdTest < ActionDispatch::IntegrationTest
  test 'should create own early bird as customer' do
    graphql_as_customer

    post graphql_path, params: { query: add_early_bird_helper(addresses(:two).id) }

    assert_response :success
    assert users(:three).addresses.pluck(:id).
                         include?(json['data']['addEarlyBird']['earlyBird']['address']['id'].to_i)
  end

  test 'should not create early bird for another address as customer' do
    graphql_as_customer

    post graphql_path, params: { query: add_early_bird_helper(addresses(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should update own early bird as customer' do
    graphql_as_customer

    post graphql_path, params: { query: update_early_bird_helper(addresses(:two).early_bird.id) }

    assert_response :success
    assert users(:three).addresses.pluck(:id).
                         include?(json['data']['updateEarlyBird']['earlyBird']['address']['id'].to_i)
  end

  test 'should not update another early bird as customer' do
    graphql_as_customer

    post graphql_path, params: { query: add_early_bird_helper(addresses(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
