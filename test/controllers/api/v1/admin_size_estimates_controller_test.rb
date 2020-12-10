require 'test_helper'

class AdminSizeEstimatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
    populate_size_estimates
    @random_se_id = SizeEstimate.pluck(:id).sample
  end

  test 'should get all size estimates as admin' do
    login_as_admin
    get api_v1_size_estimates_path, headers: @authorized_headers
    assert_response :success
    assert_equal SizeEstimate.count, json['data'].size
  end

  test 'should get any size estimate as admin' do
    get api_v1_size_estimate_path(id: @random_se_id), headers: @authorized_headers
    assert_response :success
  end

  test 'should create size estimate as admin' do
    login_as_admin
    assert_difference('SizeEstimate.count') do
      post api_v1_size_estimates_path,
           params: { size_estimate: { acreage: 0.75, address_id: Address.last.id } }.to_json,
           headers: @authorized_headers
      end
    assert_response :success
  end

  test 'should update any size estimate as admin' do
    login_as_admin
    patch api_v1_size_estimate_path(@random_se_id),
          params: { size_estimate: { acreage: 12.75 } }.to_json,
          headers: @authorized_headers
    assert_response :success
    assert_equal 12.75, SizeEstimate.find(@random_se_id).acreage
  end

  test 'should destroy any size estimate as admin' do
    login_as_admin
    se_count = SizeEstimate.count
    delete api_v1_size_estimate_path(@random_se_id), headers: @authorized_headers
    assert_response :success
    assert_equal SizeEstimate.count, se_count - 1
  end

  def populate_size_estimates
    5.times do
      address = Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                                state: Faker::Address.state, zip: Faker::Address.zip_code,
                                user_id: [User.first.id, User.last.id].sample)
      SizeEstimate.create!(acreage: Faker::Number.between(from: 0.0, to: 3.0).round(2), address_id: address.id)
    end
    Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                    state: Faker::Address.state, zip: Faker::Address.zip_code,
                    user_id: [User.first.id, User.last.id].sample)
  end
end