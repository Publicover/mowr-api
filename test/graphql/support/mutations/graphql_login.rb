# frozen_string_literal: true

module GraphqlLogin
  def log_in_to_graphql(email, password)
    post graphql_path, params: { query: graphql_login(email, password) }
  end

  def graphql_as_admin
    post graphql_path, params: { query: graphql_login(users(:admin).email, 'password') }
  end

  def graphql_as_driver
    post graphql_path, params: { query: graphql_login(users(:driver).email, 'password') }
  end

  def graphql_as_customer
    post graphql_path, params: { query: graphql_login(users(:customer).email, 'password') }
  end
end
