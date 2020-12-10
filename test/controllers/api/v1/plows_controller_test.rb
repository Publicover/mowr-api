require 'test_helper'

class PlowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
    @plow = plows(:one)
  end

  test 'admin should get full index' do
    get api_v1_plows_path, headers: @authorized_headers
    assert_response :success
    assert_equal Plow.count, json['data'].size
  end

  test 'should get show as admin' do
    get api_v1_plow_path(@plow), headers: @authorized_headers
    assert_response :success
    assert_equal @plow.id, json['data']['id'].to_i
  end

  test 'should create as admin' do
    assert_difference('Plow.count') do
      post api_v1_plows_path,
        params: {
          plow: {
            licence_plate: '100101',
            color: 'red',
            make: 'Toyota',
            model: 'Car',
            user_id: @user.id
          }
        }.to_json,
        headers: @authorized_headers
    end
    assert_response :success
  end

  test 'should update as admin' do
    patch api_v1_plow_path(@plow),
          params: { plow: { year: '2002' } }.to_json,
          headers: @authorized_headers
    assert_response :success
    assert_equal '2002', @plow.reload.year
  end

  test 'should destroy as admin' do
    plow_count = Plow.count
    delete api_v1_plow_path(@plow), headers: @authorized_headers
    assert_response :success
    assert_equal Plow.count, plow_count - 1
  end

  test 'should not get plows as driver' do
    login_as_driver
    get api_v1_plows_path, headers: @authorized_headers
    assert_equal Message.unauthorized, json['message']
  end

  test 'should not create plow as driver' do
    login_as_driver
    post api_v1_plows_path,
      params: {
        plow: {
          licence_plate: '100101',
          color: 'red',
          make: 'Toyota',
          model: 'Car',
          user_id: @user.id
        }
      }.to_json,
      headers: @authorized_headers
    assert_equal Message.unauthorized, json['message']
  end

  test 'should not get plows as customer' do
    login_as_customer
    get api_v1_plows_path, headers: @authorized_headers
    assert_equal Message.unauthorized, json['message']
  end

  test 'should not create plow as customer' do
    login_as_customer
    post api_v1_plows_path,
      params: {
        plow: {
          licence_plate: '100101',
          color: 'red',
          make: 'Toyota',
          model: 'Car',
          user_id: @user.id
        }
      }.to_json,
      headers: @authorized_headers
    assert_equal Message.unauthorized, json['message']
  end
end
