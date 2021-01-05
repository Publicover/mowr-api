require 'test_helper'

class Queries::EarlyBirdTest < ActionDispatch::IntegrationTest
  test 'should get all early birds as driver' do
    graphql_as_driver

    post graphql_path, params: { query: fetch_early_birds_helper }

    assert_response :success
    assert_equal Address.count, json['data']['fetchEarlyBirds'].size
  end

  test 'should get any early bird as driver' do
    graphql_as_driver

    post graphql_path, params: { query: fetch_early_bird_helper(early_birds(:one).id) }

    assert_response :success
    assert_equal early_birds(:one).id, json['data']['fetchEarlyBird']['id'].to_i

    post graphql_path, params: { query: fetch_early_bird_helper(early_birds(:two).id) }

    assert_response :success
    assert_equal early_birds(:two).id, json['data']['fetchEarlyBird']['id'].to_i
  end
end
