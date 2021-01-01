# frozone_string_literal: true

require 'test_helper'

class Mutations::AuthTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:three)
  end

  test 'should sign in as customer' do
    post graphql_path, params: { query: graphql_login(@user.email, "password") }

    assert_response :success
    assert_not_nil json['data']['authUser']['token']
  end
end
