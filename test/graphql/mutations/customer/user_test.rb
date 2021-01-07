require 'test_helper'

class Mutations::UserTest < ActionDispatch::IntegrationTest
  test 'should not create user as customer' do
    graphql_as_customer

    post graphql_path, params: { query: index_users_helper }

    assert_match Message.unauthorized, json['errors'][0]['message']
  end

  test 'should update own record as customer' do
    graphql_as_customer

    post graphql_path, params: { query: update_user_helper(users(:three).id) }

    assert_response :success
    assert_equal 'Fred', json['data']['updateUser']['user']['fName']
  end

  test 'should not update any user as customer' do
    graphql_as_customer

    post graphql_path, params: { query: update_user_helper(users(:one).id) }

    assert_match Message.unauthorized, json['errors'][0]['message']
  end

end
