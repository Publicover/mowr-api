require 'test_helper'

class Queries::UserTest < ActionDispatch::IntegrationTest
  test 'should not retrive all users as customer' do
    graphql_as_customer

    post graphql_path, params: { query: fetch_users_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should retrieve own record as customer' do
    user = users(:three)
    graphql_as_customer

    post graphql_path, params: { query: fetch_user_helper(user.id) }

    assert_response :success
    assert_equal user.id, json['data']['fetchUser']['id'].to_i

    post graphql_path, params: { query: fetch_user_helper(User.last.id) }

    assert_response :success
    assert_match Message.unauthorized, json['errors'][0]['message']
  end

end
