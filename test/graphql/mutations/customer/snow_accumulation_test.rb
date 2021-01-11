require 'test_helper'

class Mutations::SnowAccumulationTest < ActionDispatch::IntegrationTest
  test 'can create snow accumulation as customer' do
    graphql_as_customer

    post graphql_path, params: { query: add_snow_accumulation_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'can update snow accumulation as customer' do
    snowfall = snow_accumulations(:one)
    graphql_as_customer

    post graphql_path, params: { query: update_snow_accumulation_helper(snowfall.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should destroy snow accumulation as customer' do
    snowfall = snow_accumulations(:one)
    graphql_as_customer

    post graphql_path, params: { query: destroy_snow_accumulation_helper(snowfall.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
