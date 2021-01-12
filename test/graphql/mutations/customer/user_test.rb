require 'test_helper'

class Mutations::UserTest < ActionDispatch::IntegrationTest
  test 'should not create user as customer' do
    graphql_as_customer

    post graphql_path, params: { query: index_users_helper }

    assert_match Message.unauthorized, json['errors'][0]['message']
  end

  test 'should update own record as customer' do
    name = "Frank"
    graphql_as_customer

    post graphql_path, params: { query: update_user_helper(users(:three).id, name) }

    assert_response :success
    assert_equal name, json['data']['updateUser']['user']['fName']
  end

  test 'should not update any user as customer' do
    name = "Frank"
    graphql_as_customer

    post graphql_path, params: { query: update_user_helper(users(:one).id, name) }

    assert_match Message.unauthorized, json['errors'][0]['message']
  end

  test 'should destroy self as customer' do
    user = users(:three)
    graphql_as_customer

    post graphql_path, params: { query: destroy_user_helper(user.id) }

    assert_response :success
    assert_equal Message.is_deleted(user), json['data']['destroyUser']['isDeleted']
  end

  test 'should not destroy another user as customer' do
    user = users(:two)
    graphql_as_customer

    post graphql_path, params: { query: destroy_user_helper(user.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
