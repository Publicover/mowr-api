# frozen_string_literal: true

module GraphqlLogin
  def log_in_to_graphql(email, password)
    post graphql_path, params: { query: graphql_login(email, password) }
  end

  def graphql_as_admin
    post graphql_path, params: { query: graphql_login(users(:one).email, 'password') }
  end

  def graphql_as_driver
    post graphql_path, params: { query: graphql_login(users(:two).email, 'password') }
  end

  def graphql_as_customer
    post graphql_path, params: { query: graphql_login(users(:three).email, 'password') }
  end
end
