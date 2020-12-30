require 'test_helper'

class Mutations::AddUserTest < ActionDispatch::IntegrationTest
  test 'should create user' do
    assert_difference('User.count') do
      post graphql_path, params: { query: users_create }
    end

    assert_response :success
  end

  def users_create
    <<~GQL
    mutation {
      addUser(input: { params: {
        email:"jimgraph@graph.com",
        fName:"Jim",
        lName:"Graph",
        phone:"444-353-7575",
        role:0,
        password: "password"
      }}) { user {
        id
        email
        phone
      }}
    }
    GQL
  end
end
