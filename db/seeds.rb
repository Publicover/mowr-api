# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating 3 services..."

Service.create!(name: 'Driveway Plow', price_per_quarter_hour: 25.0)
Service.create!(name: 'De-Icing', price_per_quarter_hour: 5.0)
Service.create!(name: 'Morning Phone Call', price_per_quarter_hour: 3.0)

puts "Creating 2 admins..."

admin_count = 1
2.times do
  User.create!(email: "admin_#{admin_count}@mowr.com", f_name: Faker::Name.first_name,
  l_name: Faker::Name.last_name, password: "password", role: :admin)

  admin_count += 1
end

puts "Creating 4 drivers..."

driver_count = 1
4.times do
  User.create!(email: "driver_#{driver_count}@mowr.com", f_name: Faker::Name.first_name,
               l_name: Faker::Name.last_name, password: "password", role: :driver)

  driver_count += 1
end

puts "Creating 300 customers with addresses and size estimates..."
puts "Creating requests..."

customer_count = 1
300.times do
  user = User.create!(email: "customer_#{customer_count}@mowr.com", f_name: Faker::Name.first_name,
                      l_name: Faker::Name.last_name, password: "password", role: :customer)

  rand(5).times do
    address = Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                              state: Faker::Address.state, zip: Faker::Address.zip_code, user_id: user.id)
    SizeEstimate.create!(square_footage: Faker::Number.between(from: 20.0, to: 100.0).round(2), address_id: address.id)
    ServiceRequest.create!(address_id: address.id, approved: [true, false].sample,
                    recurring: [true, false].sample, service_ids: [Service.first.id, Service.last.id])
  end

  customer_count += 1
end

puts "Seeds complete."
