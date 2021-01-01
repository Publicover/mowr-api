require 'test_helper'

class Mutations::UserTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should create user' do
    assert_difference('User.count') do
      post graphql_path, params: { query: users_create }
    end

    assert_response :success
  end

  test 'should update user' do
    post graphql_path, params: { query: users_update }

    assert_response :success
    assert_equal 'Fred', json['data']['updateUser']['user']['fName']
  end
end
