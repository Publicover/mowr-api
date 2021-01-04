require 'test_helper'

class Queries::FetchUserTest < ActionDispatch::IntegrationTest
  # setup do
  #   @user = users(:three)
  # end

  test 'should fail without logggin in' do
    user = users(:one)
    post graphql_path, params: { query: fetch_user_helper(user.id) }
    assert_match json['message'], Message.invalid_token
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
