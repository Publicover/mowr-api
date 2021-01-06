# frozen_string_literal: true

module UsersMutation
  def add_user_helper
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

  def update_user_helper(user_id)
    <<~GQL
    mutation {
      updateUser(input:{id:#{user_id}, params:{
        fName:"Fred"
      }}) {user{
        id
        email
        fName
      }}
    }
    GQL
  end
end
