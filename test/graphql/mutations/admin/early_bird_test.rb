require 'test_helper'

class Mutations::EarlyBirdTest < ActionDispatch::IntegrationTest
  test 'should create any early bird as admin' do
    graphql_as_admin

    post graphql_path, params: { query: add_early_bird_helper(addresses(:two).id) }

    assert_response :success
    assert users(:three).addresses.pluck(:id).
                         include?(json['data']['addEarlyBird']['earlyBird']['address']['id'].to_i)

    post graphql_path, params: { query: add_early_bird_helper(addresses(:one).id) }

    assert_response :success
    assert users(:one).addresses.pluck(:id).
                         include?(json['data']['addEarlyBird']['earlyBird']['address']['id'].to_i)
  end

  test 'should update any early bird as admin' do
    graphql_as_admin

    post graphql_path, params: { query: update_early_bird_helper(addresses(:two).early_bird.id) }

    assert_response :success
    assert users(:three).addresses.pluck(:id).
                         include?(json['data']['updateEarlyBird']['earlyBird']['address']['id'].to_i)

    post graphql_path, params: { query: update_early_bird_helper(addresses(:two).early_bird.id) }

    assert_response :success
    assert users(:three).addresses.pluck(:id).
                         include?(json['data']['updateEarlyBird']['earlyBird']['address']['id'].to_i)
  end
end
