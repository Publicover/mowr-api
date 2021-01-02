require 'test_helper'

class Queries::FetchUsersTest < ActionDispatch::IntegrationTest
  test 'should retrieve all users' do
    graphql_as_admin

    post graphql_path, params: { query: users_index }

    assert_response :success
    assert_equal User.count, json['data']['fetchUsers'].size
  end
end
