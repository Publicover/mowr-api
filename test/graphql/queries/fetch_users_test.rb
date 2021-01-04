require 'test_helper'

class Queries::FetchUsersTest < ActionDispatch::IntegrationTest
  test 'should fail if not signed in' do
    post graphql_path, params: { query: fetch_users_helper }
    assert_match json['message'], Message.invalid_token
  end

  test 'should retrieve all users as admin' do
    graphql_as_admin

    post graphql_path, params: { query: fetch_users_helper }

    assert_response :success
    assert_equal User.count, json['data']['fetchUsers'].size
  end
end
