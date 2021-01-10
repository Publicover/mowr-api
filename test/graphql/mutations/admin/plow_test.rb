require 'test_helper'

class Mutations::PlowTest < ActionDispatch::IntegrationTest
  test 'can create plow as admin' do
    graphql_as_admin

    assert_difference('Plow.count') do
      post graphql_path, params: { query: add_plow_helper(users(:one).id) }
    end
  end

  test 'should update plow as admin' do
    graphql_as_admin

    post graphql_path, params: { query: update_plow_helper(plows(:one).id) }

    assert_response :success
    assert_equal plows(:one).reload.licence_plate, json['data']['updatePlow']['plow']['licencePlate']
  end

  test 'should destroy plow as admin' do
    graphql_as_admin

    assert_difference('Plow.count', -1) do
      post graphql_path, params: { query: destroy_plow_helper(plows(:one).id) }
    end
  end
end
