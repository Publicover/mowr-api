require 'test_helper'

class Queries::FetchUserTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should fail without logggin in' do
    post graphql_path, params: { query: users_show }
    assert_match json['message'], Message.invalid_token
  end

  test 'should retrieve single user' do
    graphql_as_admin

    post graphql_path, params: { query: users_show }

    assert_response :success
    assert_equal @user.id, json['data']['fetchUser']['id'].to_i
  end
end
