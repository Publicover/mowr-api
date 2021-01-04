require 'test_helper'

class Mutations::UserTest < ActionDispatch::IntegrationTest
  test 'should not create user as driver' do
    graphql_as_driver

    assert_difference('User.count') do
      post graphql_path, params: { query: add_user_helper }
    end

    assert_response :success
  end

  test 'should update own record as driver' do
    graphql_as_driver

    post graphql_path, params: { query: update_user_helper(users(:two).id) }

    assert_response :success
    assert_equal 'Fred', json['data']['updateUser']['user']['fName']
  end

  test 'should not update any user as driver' do
    graphql_as_driver

    post graphql_path, params: { query: update_user_helper(users(:three).id) }

    assert_match Message.unauthorized, json['errors'][0]['message']
  end

end
