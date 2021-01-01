module AuthMutation
  def graphql_login(email, password)
    <<~GQL
      mutation {
        authUser(input: {params: {email: "#{email}", password: "#{password}"}}) {
          token
          user {
            id
          }
        }
      }
    GQL
  end
end
