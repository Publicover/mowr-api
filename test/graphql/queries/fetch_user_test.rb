require 'test_helper'

class Queries::FetchUserTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should retrieve single user' do
    post graphql_path, params: { query: users_show }

    assert_response :success
    assert_equal @user.id, json['data']['fetchUser']['id'].to_i
  end

  def users_show
    <<~GQL
      query {
        fetchUser(id:#{@user.id}) {
          id
          email
          phone
        }
      }
    GQL
  end


end
