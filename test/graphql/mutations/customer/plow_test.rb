require 'test_helper'

class Mutations::PlowTest < ActionDispatch::IntegrationTest
  test 'cannot create plow as customer' do
    graphql_as_customer

    post graphql_path, params: { query: create_plow_helper(users(:admin).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not update plow as customer' do
    plate = "ICU81MI"
    graphql_as_customer

    post graphql_path, params: { query: update_plow_helper(plows(:one).id, plate) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not destroy plow as customer' do
    graphql_as_customer

    post graphql_path, params: { query: destroy_plow_helper(plows(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
