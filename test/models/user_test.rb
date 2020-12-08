require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should validate email' do
    user = User.new(f_name: 'tester', l_name: 'mcgee', role: :customer, password: 'testinghere')
    assert_not user.save
    assert_not_nil user.errors[:email]
  end

  test 'should validate f_name' do
    user = User.new(email: 'test@test.com', l_name: 'mcgee', role: :customer, password: 'testinghere')
    assert_not user.save
    assert_not_nil user.errors[:f_name]
  end

  test 'should validate l_name' do
    user = User.new(f_name: 'tester', email: 'test@test.com', role: :customer, password: 'testinghere')
    assert_not user.save
    assert_not_nil user.errors[:l_name]
  end

  test 'should validate role' do
    user = User.new(f_name: 'tester', l_name: 'mcgee', email: 'test@test.com', password: 'testinghere')
    assert_not user.save
    assert_not_nil user.errors[:email]
  end

  test 'should validate password' do
    user = User.new(f_name: 'tester', l_name: 'mcgee', role: :customer, email: 'test@test.com')
    assert_not user.save
    assert_not_nil user.errors[:email]
  end
end
