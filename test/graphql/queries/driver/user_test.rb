require 'test_helper'

class Queries::UserTest < ActionDispatch::IntegrationTest
  test 'should retrieve all users as driver' do
    graphql_as_driver

    post graphql_path, params: { query: fetch_users_helper }

    assert_response :success
    assert_equal User.count, json['data']['fetchUsers'].size
  end

  test 'should retrieve own record as driver' do
    user = users(:two)
    graphql_as_driver

    post graphql_path, params: { query: fetch_user_helper(user.id) }

    assert_response :success
    assert_equal user.id, json['data']['fetchUser']['id'].to_i

    post graphql_path, params: { query: fetch_user_helper(User.first.id) }

    assert_response :success
    assert_equal User.first.id, json['data']['fetchUser']['id'].to_i
  end
end
