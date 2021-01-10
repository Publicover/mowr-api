require 'test_helper'

class Queries::PlowTest < ActionDispatch::IntegrationTest
  test 'should not get plows as customer' do
    graphql_as_customer

    post graphql_path, params: { query: index_plows_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not get single plow as customer' do
    graphql_as_customer

    post graphql_path, params: { query: show_plow_helper(plows(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
