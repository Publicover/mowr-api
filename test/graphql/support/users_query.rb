# frozen_string_literal: true

module UsersQuery
  def fetch_users_helper
    <<~GQL
      query { fetchUsers {
          id
          email
        }
      }
    GQL
  end

  def fetch_user_helper(user_id)
    <<~GQL
      query {
        fetchUser(id:#{user_id}) {
          id
          email
          phone
        }
      }
    GQL
  end
end
