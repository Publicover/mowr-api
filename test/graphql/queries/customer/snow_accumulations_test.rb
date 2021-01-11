require 'test_helper'

class Queries::SnowAccumulationsTest < ActionDispatch::IntegrationTest
  test 'should not get snow accumulations as customer' do
    graphql_as_customer

    post graphql_path, params: { query: index_snow_accumulations_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not get single accumulation as customer' do
    graphql_as_customer

    post graphql_path, params: { query: show_snow_accumulations_helper(snow_accumulations(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
