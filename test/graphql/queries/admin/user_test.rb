require 'test_helper'

class Queries::UserTest < ActionDispatch::IntegrationTest
  test 'should fail without logggin in' do
    user = users(:one)
    post graphql_path, params: { query: fetch_user_helper(user.id) }
    assert_match json['message'], Message.invalid_token
  end

  test 'should retrieve all users as admin' do
    graphql_as_admin

    post graphql_path, params: { query: fetch_users_helper }

    assert_response :success
    assert_equal User.count, json['data']['fetchUsers'].size
  end

  test 'should retrieve any single user as admin' do
    user = users(:three)
    graphql_as_admin

    post graphql_path, params: { query: fetch_user_helper(user.id) }

    assert_response :success
    assert_equal user.id, json['data']['fetchUser']['id'].to_i

    post graphql_path, params: { query: fetch_user_helper(User.first.id) }

    assert_response :success
    assert_equal User.first.id, json['data']['fetchUser']['id'].to_i
  end
end
