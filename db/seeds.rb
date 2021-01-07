# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Creating Home Base..."

BaseLocation.create!(name: 'Plowr HQ', line1: '2828 W 13th St', city: 'Ashtabula',
                 state: 'OH', zip: '44004', latitude: 41.885948, longitude: -80.824458)

puts "Creating 2 plows..."

Plow.create!(licence_plate: 'PLOWISLYFE', year: "2000", color: "blue",
             make: "Big", model: "Plow", user_id: 1)
Plow.create!(licence_plate: 'ITSALIVIN', year: "2000", color: "blue",
             make: "Big", model: "Plow", user_id: 1)

puts "Populating SnowAccumulation table..."

10.times do
  SnowAccumulation.create!(inches: Faker::Number.within(range: 1..24))
end

puts "Creating 3 services..."

Service.create!(name: 'Driveway Plow', price_per_inch_of_snow: 5,
                price_per_driveway: [25, 40, 60])
Service.create!(name: 'De-Icing', price_per_inch_of_snow: 5,
                price_per_driveway: [10, 15, 20])
Service.create!(name: 'Snowblower Rental', price_per_inch_of_snow: 5,
                price_per_driveway: [25, 35, 45])

puts "Creating 2 admins..."

admin_count = 1
2.times do
  User.create!(email: "admin_#{admin_count}@mowr.com", f_name: Faker::Name.first_name,
               l_name: Faker::Name.last_name, password: "password", role: :admin,
               phone: Faker::PhoneNumber.phone_number)

  admin_count += 1
end

puts "Creating 4 drivers..."

driver_count = 1
4.times do
  User.create!(email: "driver_#{driver_count}@mowr.com", f_name: Faker::Name.first_name,
               l_name: Faker::Name.last_name, password: "password", role: :driver,
               phone: Faker::PhoneNumber.phone_number)

  driver_count += 1
end

puts "Creating 300 customers with addresses and size estimates..."
puts "With requests..."
puts "And a few early bird specials..."

customer_count = 1

300.times do
  user = User.create!(email: "customer_#{customer_count}@mowr.com", f_name: Faker::Name.first_name,
                      l_name: Faker::Name.last_name, password: "password", role: :customer,
                      phone: Faker::PhoneNumber.phone_number)

  rand(5).times do
    address = Address.create!(line1: Faker::Address.street_address, city: Faker::Address.city,
                              state: Faker::Address.state, zip: Faker::Address.zip_code, user_id: user.id,
                              latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                              name: Faker::Company.name, driveway: [:small, :medium, :large].sample)
    SizeEstimate.create!(address_id: address.id, square_footage: rand(50..500))
    ServiceRequest.create!(address_id: address.id, service_ids: [Service.first.id, Service.last.id])
    ServiceDelivery.create!(address_id: address.id)

    rand(10) == 5 ? EarlyBird.create(address_id: address.id, priority: :active) : next
  end

  customer_count += 1
end

puts "Creating service deliveries..."

# Address.each do |address|
#   ServiceDelivery.create(cost: address.service)
# end

puts "Seeds complete."
