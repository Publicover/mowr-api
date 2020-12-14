require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should validate email' do
    user = User.new(f_name: 'tester', l_name: 'mcgee', role: :customer,
                    password: 'testinghere', phone: Faker::PhoneNumber.phone_number)
    assert_not user.save
    assert_not_nil user.errors[:email]
  end

  test 'should validate f_name' do
    user = User.new(email: 'test@test.com', l_name: 'mcgee', role: :customer,
                    password: 'testinghere', phone: Faker::PhoneNumber.phone_number)
    assert_not user.save
    assert_not_nil user.errors[:f_name]
  end

  test 'should validate l_name' do
    user = User.new(f_name: 'tester', email: 'test@test.com', role: :customer,
                    password: 'testinghere', phone: Faker::PhoneNumber.phone_number)
    assert_not user.save
    assert_not_nil user.errors[:l_name]
  end

  test 'should validate role' do
    user = User.new(f_name: 'tester', l_name: 'mcgee', email: 'test@test.com',
                    password: 'testinghere', phone: Faker::PhoneNumber.phone_number)
    assert_not user.save
    assert_not_nil user.errors[:email]
  end

  test 'should validate password' do
    user = User.new(f_name: 'tester', l_name: 'mcgee', role: :customer,
                    email: 'test@test.com', phone: Faker::PhoneNumber.phone_number)
    assert_not user.save
    assert_not_nil user.errors[:email]
  end

  test 'should validate phone number' do
    user = User.new(f_name: 'tester', l_name: 'mcgee', role: :customer,
                    email: 'test@test.com', password: 'testinghere')
    assert_not user.save
    assert_not_nil user.errors[:email]
  end

  test 'phone number comes back out' do
    user = User.new(f_name: 'tester', l_name: 'mcgee', role: :customer,
                    email: 'test@test.com', password: 'testinghere',
                    phone: Faker::PhoneNumber.phone_number)
    user.save
    assert_not_nil user.phone.phony_formatted
  end

  # test 'should validate phone number format' do
  #   user_count = User.count
  #   user = User.new(f_name: 'tester', l_name: 'mcgee', role: :customer, email: 'test@test.com',
  #                   password: 'testinghere', phone: '33445555')
  #   assert_not user.save
  #
  #   assert_match user.errors[:phone][0], 'Phone numbers must be in xxx-xxx-xxxx format.'
  #   user = User.new(f_name: 'tester', l_name: 'mcgee', role: :customer, email: 'test@test.com',
  #                   password: 'testinghere', phone: Faker::PhoneNumber.phone_number)
  #   assert user.save
  #   assert_equal User.count, user_count + 1
  # end
end
