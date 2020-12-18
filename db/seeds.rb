# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating 3 services..."

Service.create!(name: 'Driveway Plow', price_per_sq_ft: 0.30, price_per_inch_of_snow: 5,
                price_per_season: 150.0)
Service.create!(name: 'De-Icing', price_per_sq_ft: 0.50, price_per_inch_of_snow: 5,
                price_per_season: 75.0)
Service.create!(name: 'Morning Phone Call', price_per_sq_ft: 0.01, price_per_inch_of_snow: 5,
                price_per_season: 10.0)
Service.create!(name: 'Early Bird List', price_per_sq_ft: 0.10, price_per_inch_of_snow: 5,
                price_per_season: 1.0)

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
puts "With a few early bird specials..."

customer_count = 1
300.times do
  user = User.create!(email: "customer_#{customer_count}@mowr.com", f_name: Faker::Name.first_name,
                      l_name: Faker::Name.last_name, password: "password", role: :customer,
                      phone: Faker::PhoneNumber.phone_number)

  rand(5).times do
    address = Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                              state: Faker::Address.state, zip: Faker::Address.zip_code, user_id: user.id,
                              latitude: Faker::Location.latitude, longitude: Faker.Location.longitude,
                              name: Faker::Company.name)
    SizeEstimate.create!(square_footage: Faker::Number.between(from: 20.0, to: 100.0).round(2), address_id: address.id)
    ServiceRequest.create!(address_id: address.id, approved: [true, false].sample,
                    recurring: [true, false].sample, service_ids: [Service.first.id, Service.last.id])

    rand(10) == 5 ? EarlyBird.create(address_id: address.id, priority: :active) : return
  end

  customer_count += 1
end

puts "Seeds complete."
