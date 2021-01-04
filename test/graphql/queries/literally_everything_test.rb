require 'test_helper'

class Queries::LiterallyEverythingTest < ActionDispatch::IntegrationTest
  setup do
    populate_addresses_with_early_birds
  end

  test 'return just literally everything' do
    graphql_as_admin

    post graphql_path, params: { query: fetch_everything_helper }

    assert_response :success
    assert_not_nil json['data']
    assert_not_nil json['data']['fetchUsers']
    assert_not_nil json['data']['fetchUsers'][0]
    assert_not_nil json['data']['fetchUsers'][0]['addresses']
    assert_equal Address.where(user_id: json['data']['fetchUsers'][0]['id']).count,
                 json['data']['fetchUsers'][0]['addresses'].size
    assert_not_nil json['data']['fetchUsers'][1]
    assert_not_nil json['data']['fetchUsers'][2]
    assert_not_nil json['data']['fetchUsers'][2]['addresses']
    assert_equal Address.where(user_id: json['data']['fetchUsers'][2]['id']).count,
                 json['data']['fetchUsers'][2]['addresses'].size
  end
end
