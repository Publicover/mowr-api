require 'test_helper'

class PlowTest < ActiveSupport::TestCase
  test 'should validate licence plate' do
    plow = Plow.new(year: '1992', make: 'Toyota', model: 'Corolla', color: 'red')
    assert_not plow.save
    assert_not_nil plow.errors[:licence_plate]
  end
end
