# frozen_string_literal: true

module UsersMutation
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

  def users_update
    <<~GQL
    mutation {
      updateUser(input: { id:#{@user.id}, params: {
        fName:"Fred"
      }}) { user {
        id
        email
        fName
      }}
    }
    GQL
  end
end
