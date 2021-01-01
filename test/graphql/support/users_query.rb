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
