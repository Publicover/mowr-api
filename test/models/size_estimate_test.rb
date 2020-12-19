require 'test_helper'

class SizeEstimateTest < ActiveSupport::TestCase
  setup do
    @size_estimate = size_estimates(:one)
  end

  test 'should know address' do
    assert_not_nil @size_estimate.address
  end

  test 'should know user' do
    assert_equal users(:one).id, @size_estimate.user.id
  end

  # test 'should confirm parent address estimate after creation' do
  #   address = Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
  #                             state: Faker::Address.state, zip: Faker::Address.zip_code,
  #                             user_id: [User.first.id, User.last.id].sample,
  #                             latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
  #                             name: Faker::Company.name, driveway: [:small, :medium, :large].sample)
  #   size_estimate = SizeEstimate.create!(address_id: address.id, square_footage: 10.0)
  #
  #   assert address.reload.estimate_complete
  # end
end
