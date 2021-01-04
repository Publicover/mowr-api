# frozen_string_literal: true

module UsersQuery
  def users_index
    <<~GQL
      query { fetchUsers {
          id
          email
        }
      }
    GQL
  end

  def users_show(user_id)
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
