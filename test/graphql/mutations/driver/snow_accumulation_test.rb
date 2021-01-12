require 'test_helper'

class Mutations::SnowAccumulationTest < ActionDispatch::IntegrationTest
  test 'cannot create snow accumulation as driver' do
    graphql_as_driver

    post graphql_path, params: { query: create_snow_accumulation_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not update snow accumulation as driver' do
    snow = 24
    snowfall = snow_accumulations(:one)
    graphql_as_driver

    post graphql_path, params: { query: update_snow_accumulation_helper(snowfall.id, snow) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not destroy snow accumulation as driver' do
    snowfall = snow_accumulations(:one)
    graphql_as_driver

    post graphql_path, params: { query: destroy_snow_accumulation_helper(snowfall.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
