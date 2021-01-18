require 'test_helper'

class Mutations::EarlyBirdTest < ActionDispatch::IntegrationTest
  test 'should create any early bird as admin' do
    graphql_as_admin

    post graphql_path, params: { query: create_early_bird_helper(addresses(:two).id) }

    assert_response :success
    assert users(:customer).addresses.pluck(:id).
                         include?(json['data']['createEarlyBird']['earlyBird']['address']['id'].to_i)

    post graphql_path, params: { query: create_early_bird_helper(addresses(:one).id) }

    assert_response :success
    assert users(:admin).addresses.pluck(:id).
                         include?(json['data']['createEarlyBird']['earlyBird']['address']['id'].to_i)
  end

  test 'should update any early bird as admin' do
    early_bird = early_birds(:one)
    priority = 1
    graphql_as_admin

    post graphql_path, params: { query: update_early_bird_helper(addresses(:two).early_bird.id, priority) }

    assert_response :success
    assert addresses(:two).early_bird.reload.priority, priority
  end

  test 'should destroy any early bird as admin' do
    early_bird = early_birds(:two)
    graphql_as_admin

    post graphql_path, params: { query: destroy_early_bird_helper(early_bird.id) }

    assert_response :success
    assert_equal Message.is_deleted(early_bird), json['data']['destroyEarlyBird']['isDeleted']
  end
end
