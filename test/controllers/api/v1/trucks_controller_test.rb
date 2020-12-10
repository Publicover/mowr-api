require 'test_helper'

class TrucksControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
    @truck = trucks(:one)
  end

  test 'admin should get full index' do
    get api_v1_trucks_path, headers: @authorized_headers
    assert_response :success
    assert_equal Truck.count, json['data'].size
  end

  test 'should get show as admin' do
    get api_v1_truck_path(@truck), headers: @authorized_headers
    assert_response :success
    assert_equal @truck.id, json['data']['id'].to_i
  end

  test 'should create as admin' do
    assert_difference('Truck.count') do
      post api_v1_trucks_path,
        params: {
          truck: {
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
    patch api_v1_truck_path(@truck),
          params: { truck: { year: '2002' } }.to_json,
          headers: @authorized_headers
    assert_response :success
    assert_equal '2002', @truck.reload.year
  end

  test 'should destroy as admin' do
    truck_count = Truck.count
    delete api_v1_truck_path(@truck), headers: @authorized_headers
    assert_response :success
    assert_equal Truck.count, truck_count - 1
  end

  test 'should not get trucks as driver' do
    login_as_driver
    get api_v1_trucks_path, headers: @authorized_headers
    assert_equal Message.unauthorized, json['message']
  end

  test 'should not create truck as driver' do
    login_as_driver
    post api_v1_trucks_path,
      params: {
        truck: {
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

  test 'should not get trucks as customer' do
    login_as_customer
    get api_v1_trucks_path, headers: @authorized_headers
    assert_equal Message.unauthorized, json['message']
  end

  test 'should not create truck as customer' do
    login_as_customer
    post api_v1_trucks_path,
      params: {
        truck: {
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
