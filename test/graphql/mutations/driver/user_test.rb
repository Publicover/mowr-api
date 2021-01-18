require 'test_helper'

class Mutations::UserTest < ActionDispatch::IntegrationTest
  test 'should not create user as driver' do
    graphql_as_driver

    assert_difference('User.count') do
      post graphql_path, params: { query: create_user_helper }
    end

    assert_response :success
  end

  test 'should update own record as driver' do
    name = "Frank"
    graphql_as_driver

    post graphql_path, params: { query: update_user_helper(users(:driver).id, name) }

    assert_response :success
    assert_equal name, json['data']['updateUser']['user']['fName']
  end

  test 'should not update any user as driver' do
    name = "Frank"
    graphql_as_driver

    post graphql_path, params: { query: update_user_helper(users(:customer).id, name) }

    assert_match Message.unauthorized, json['errors'][0]['message']
  end

  test 'should destroy self as driver' do
    user = users(:driver)
    graphql_as_driver

    post graphql_path, params: { query: destroy_user_helper(user.id) }

    assert_response :success
    assert_equal Message.is_deleted(user), json['data']['destroyUser']['isDeleted']
  end

  test 'should not destroy another user as driver' do
    user = users(:customer)
    graphql_as_driver

    post graphql_path, params: { query: destroy_user_helper(user.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
