require 'test_helper'

class Mutations::UpdateUserTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should update user' do
    post graphql_path, params: { query: users_update }

    assert_response :success
    assert_equal 'Fred', json['data']['updateUser']['user']['fName']
  end

  def users_update
    <<~GQL
    mutation {
      updateUser(input: { id:#{@user.id}, params: {
        fName:"Fred"
      }}) { user {
        id
        email
        fName
      }}
    }
    GQL
  end
end
