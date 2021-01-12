require 'test_helper'

class Mutations::EarlyBirdTest < ActionDispatch::IntegrationTest
  test 'should not create any early bird as driver' do
    graphql_as_driver

    post graphql_path, params: { query: create_early_bird_helper(addresses(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not update any early bird as driver' do
    graphql_as_driver

    post graphql_path, params: { query: update_early_bird_helper(addresses(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not destroy early bird as driver' do
    early_bird = early_birds(:one)
    graphql_as_driver

    post graphql_path, params: { query: destroy_early_bird_helper(early_bird.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
