# frozen_string_literal: true

module UsersQuery
  def index_users_helper
    <<~GQL
      query { indexUsers {
          id
          email
        }
      }
    GQL
  end

  def show_user_helper(user_id)
    <<~GQL
      query {
        showUser(id:#{user_id}) {
          id
          email
          phone
        }
      }
    GQL
  end
end
