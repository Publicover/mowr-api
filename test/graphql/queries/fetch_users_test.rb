require 'test_helper'

class Queries::FetchUsersTest < ActionDispatch::IntegrationTest
  test 'should retrieve all users' do
    post graphql_path, params: { query: users_index }

    assert_response :success
    assert_equal User.count, json['data']['fetchUsers'].size
  end

  def users_index
    <<~GQL
      query { fetchUsers {
          id
          email
        }
      }
    GQL
  end
end
