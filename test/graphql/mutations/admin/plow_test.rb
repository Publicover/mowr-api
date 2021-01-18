require 'test_helper'

class Mutations::PlowTest < ActionDispatch::IntegrationTest
  test 'can create plow as admin' do
    graphql_as_admin

    assert_difference('Plow.count') do
      post graphql_path, params: { query: create_plow_helper(users(:admin).id) }
    end
  end

  test 'should update plow as admin' do
    plate = "ICU81MI"
    graphql_as_admin

    post graphql_path, params: { query: update_plow_helper(plows(:one).id, plate) }

    assert_response :success
    assert_equal plows(:one).reload.licence_plate, plate
  end

  test 'should destroy plow as admin' do
    graphql_as_admin

    assert_difference('Plow.count', -1) do
      post graphql_path, params: { query: destroy_plow_helper(plows(:one).id) }
    end
  end

  test 'should fail gracefully' do
    graphql_as_admin

    post graphql_path, params: { query: failure_to_create_helper(users(:admin).id) }

    assert_response :success
    assert_not_nil json['errors'][0]['message']

    post graphql_path, params: { query: failure_to_update_helper(plows(:one).id) }

    assert_response :success
    assert_not_nil json['errors'][0]['message']

    post graphql_path, params: { query: failure_to_destroy_helper }

    assert_response :success
    assert_not_nil json['errors'][0]['message']
  end
end
