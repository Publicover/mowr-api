require 'test_helper'

class Mutations::SnowAccumulationTest < ActionDispatch::IntegrationTest
  test 'can create snow accumulation as admin' do
    graphql_as_admin

    assert_difference('SnowAccumulation.count') do
      post graphql_path, params: { query: add_snow_accumulation_helper }
    end
  end

  test 'can update snow accumulation as admin' do
    snowfall = snow_accumulations(:one)
    graphql_as_admin

    post graphql_path, params: { query: update_snow_accumulation_helper(snowfall.id) }

    assert_response :success
    assert_equal snowfall.reload.inches, json['data']['udpateSnowAccumulation']['snowAccumulation']['inches']
  end

  test 'should destroy snow accumulation as admin' do
    snowfall = snow_accumulations(:one)
    graphql_as_admin

    assert_difference('SnowAccumulation.count', -1) do
      post graphql_path, params: { query: destroy_snow_accumulation_helper(snowfall.id) }
    end
  end
end
