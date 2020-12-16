require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test 'should validate line_1' do
    address = Address.new(city: 'Testington', state: 'NC', zip: '19824', user_id: @user.id)
    assert_not address.save
    assert_not_nil address.errors[:line_1]
  end

  test 'should validate city' do
    address = Address.new(line_1: '123 Test St', state: 'NC', zip: '19824', user_id: @user.id)
    assert_not address.save
    assert_not_nil address.errors[:city]
  end

  test 'should validate state' do
    address = Address.new(line_1: '123 Test St', city: 'Testington', zip: '19824', user_id: @user.id)
    assert_not address.save
    assert_not_nil address.errors[:state]
  end

  test 'should validate zip' do
    address = Address.new(line_1: '123 Test St', city: 'Testington', state: 'NC', user_id: @user.id)
    assert_not address.save
    assert_not_nil address.errors[:zip]
  end

  test 'should validate user_id' do
    address = Address.new(line_1: '123 Test St', city: 'Testington', state: 'NC', zip: '19824')
    assert_not address.save
    assert_not_nil address.errors[:zip]
  end

  test 'should return compact_address' do
    address = addresses(:one)
    assert address.compact_address
  end

  test 'should geocode after_validation' do
    user = users(:three)
    Address.create!(line_1: '3300 Lake Rd W', city: 'Ashtabula', state: 'Ohio',
                    zip: '44004', name: 'KSU', user_id: user.id)
    assert_not_nil Address.last.latitude
    assert_not_nil Address.last.longitude
  end
end
