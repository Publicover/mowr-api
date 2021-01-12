# frozen_string_literal: true

module UsersMutation
  def create_user_helper
    <<~GQL
    mutation {
      createUser(input: { params: {
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

  def update_user_helper(user_id, name)
    <<~GQL
    mutation {
      updateUser(input:{id:#{user_id}, params:{
        fName:"#{name}"
      }}) {user{
        id
        email
        fName
      }}
    }
    GQL
  end

  def destroy_user_helper(id)
    <<~GQL
      mutation {
        destroyUser(input:{id:#{id}}) {
          isDeleted
        }
      }
    GQL
  end
end
