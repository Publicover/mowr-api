require 'test_helper'

class TruckTest < ActiveSupport::TestCase
  test 'should validate licence plate' do
    truck = Truck.new(year: '1992', make: 'Toyota', model: 'Corolla', color: 'red')
    assert_not truck.save
    assert_not_nil truck.errors[:licence_plate]
  end
end
