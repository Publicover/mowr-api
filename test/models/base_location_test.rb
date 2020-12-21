require 'test_helper'

class BaseLocationTest < ActiveSupport::TestCase
  test 'should validate line_1' do
    base = BaseLocation.new(name: 'Plowr HQ', city: 'Testington', state: 'NC', zip: '19824')
    assert_not base.save
    assert_not_nil base.errors[:line_1]
  end

  test 'should validate city' do
    base = BaseLocation.new(line_1: '123 Test St', state: 'NC', zip: '19824')
    assert_not base.save
    assert_not_nil base.errors[:city]
  end

  test 'should validate state' do
    base = BaseLocation.new(line_1: '123 Test St', city: 'Testington', zip: '19824')
    assert_not base.save
    assert_not_nil base.errors[:state]
  end

  test 'should validate zip' do
    base = BaseLocation.new(line_1: '123 Test St', city: 'Testington', state: 'NC')
    assert_not base.save
    assert_not_nil base.errors[:zip]
  end

  test 'should return compact_address' do
    base = base_locations(:one)
    assert base.compact_address
  end

  test 'should geocode after_validation' do
    VCR.use_cassette('home base unit create') do
      BaseLocation.create!(name: 'Plowr HQ', line_1: '2828 W 13th St',
                       city: 'Ashtabula', state: 'Ohio', zip: '44004')
    end
    assert_not_nil BaseLocation.last.latitude
    assert_not_nil BaseLocation.last.longitude
  end
end
