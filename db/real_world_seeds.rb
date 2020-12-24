puts "Creating Home Base..."

BaseLocation.create!(name: 'Plowr HQ', line_1: '2828 W 13th St', city: 'Ashtabula',
                 state: 'OH', zip: '44004', latitude: 41.885948, longitude: -80.824458)

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

puts "Creating one robber baron who owns all addresses..."

user = User.create!(email: "customer_robber_baron@mowr.com", f_name: Faker::Name.first_name,
                    l_name: Faker::Name.last_name, password: "password", role: :customer,
                    phone: Faker::PhoneNumber.phone_number)

puts "Creating 7 real-world addresses with early_birds and 6 without..."

hil_mak = Address.create!(line_1: '449 Lake Ave', city: 'Ashtabula',
                          state: 'OH', zip: '44004', name: 'Hil-Mak Seafood', user_id: user.id)
          # lat: 41.89705, long: -80.80487
SizeEstimate.create!(address_id: hil_mak.id)
ServiceRequest.create!(address_id: hil_mak.id, service_ids: Service.pluck(:id))
EarlyBird.create!(priority: :active, address_id: hil_mak.id)
ServiceDelivery.create!(address_id: hil_mak.id)

cloven = Address.create!(line_1: '1308 Bridge St', city: 'Ashtabula',
                         state: 'OH', zip: '44004', name: 'Cloven Hoof Brewery', user_id: user.id)
          # lat: 41.898124, long: -80.802088
SizeEstimate.create!(address_id: cloven.id)
ServiceRequest.create!(address_id: cloven.id, service_ids: Service.pluck(:id))
EarlyBird.create!(priority: :active, address_id: cloven.id)
ServiceDelivery.create!(address_id: cloven.id)

morrell = Address.create!(line_1: '1040 E 6th St', city: 'Ashtabula',
                          state: 'OH', zip: '44004', name: 'Morrell Music', user_id: user.id)
          # lat: 41.900144, long: -80.787492
SizeEstimate.create!(address_id: morrell.id)
ServiceRequest.create!(address_id: morrell.id, service_ids: Service.pluck(:id))
EarlyBird.create!(priority: :active, address_id: morrell.id)
ServiceDelivery.create!(address_id: morrell.id)

dollar = Address.create!(line_1: '1708 W Prospect Rd', city: 'Ashtabula',
                         state: 'OH', zip: '44004', name: 'Dollar General', user_id: user.id)
SizeEstimate.create!(address_id: dollar.id)
ServiceRequest.create!(address_id: dollar.id, service_ids: Service.pluck(:id))
EarlyBird.create!(priority: :active, address_id: dollar.id)
ServiceDelivery.create!(address_id: dollar.id)

lake_shore = Address.create!(line_1: '2234 Lake Ave', city: 'Ashtabula',
                             state: 'OH', zip: '44004', name: 'Lake Shore Lanes', user_id: user.id)
SizeEstimate.create!(address_id: lake_shore.id)
ServiceRequest.create!(address_id: lake_shore.id, service_ids: Service.pluck(:id))
EarlyBird.create!(priority: :active, address_id: lake_shore.id)
ServiceDelivery.create!(address_id: lake_shore.id)

capos = Address.create!(line_1: '1205 Lake Ave', city: 'Ashtabula',
                        state: 'OH', zip: '44004', name: "Capo's Pizza", user_id: user.id)
SizeEstimate.create!(address_id: capos.id)
ServiceRequest.create!(address_id: capos.id, service_ids: Service.pluck(:id))
EarlyBird.create!(priority: :active, address_id: capos.id)
ServiceDelivery.create!(address_id: capos.id)

main_moon = Address.create!(line_1: '1030 Lake Ave', city: 'Ashtabula',
                            state: 'OH', zip: '44004', name: 'Main Moon', user_id: user.id)
SizeEstimate.create!(address_id: main_moon.id)
ServiceRequest.create!(address_id: main_moon.id, service_ids: Service.pluck(:id))
EarlyBird.create!(priority: :active, address_id: main_moon.id)
ServiceDelivery.create!(address_id: main_moon.id)

add1 = Address.create!(line_1: '729 Lake Ave', city: 'Ashtabula',
                        state: 'OH', zip: '44004', name: 'Lakeway Restaurant', user_id: user.id)
SizeEstimate.create!(address_id: add1.id)
ServiceRequest.create!(address_id: add1.id, service_ids: Service.pluck(:id))
ServiceDelivery.create!(address_id: add1.id)

add2 = Address.create!(line_1: '1166 Lake Ave', city: 'Ashtabula',
                        state: 'OH', zip: '44004', name: 'Hospice', user_id: user.id)
SizeEstimate.create!(address_id: add2.id)
ServiceRequest.create!(address_id: add2.id, service_ids: Service.pluck(:id))
ServiceDelivery.create!(address_id: add2.id)

add3 = Address.create!(line_1: '621 Goodwill Dr', city: 'Ashtabula',
                        state: 'OH', zip: '44004', name: 'Goodwill', user_id: user.id)
SizeEstimate.create!(address_id: add3.id)
ServiceRequest.create!(address_id: add3.id, service_ids: Service.pluck(:id))
ServiceDelivery.create!(address_id: add3.id)

add4 = Address.create!(line_1: '1 Ferry Dr', city: 'Ashtabula',
                        state: 'OH', zip: '44004', name: 'Harbor Yak', user_id: user.id)
SizeEstimate.create!(address_id: add4.id)
ServiceRequest.create!(address_id: add4.id, service_ids: Service.pluck(:id))
ServiceDelivery.create!(address_id: add4.id)

add5 = Address.create!(line_1: '1257 Harmon Rd', city: 'Ashtabula',
                        state: 'OH', zip: '44004', name: "Crow's Nest", user_id: user.id)
SizeEstimate.create!(address_id: add5.id)
ServiceRequest.create!(address_id: add5.id, service_ids: Service.pluck(:id))
ServiceDelivery.create!(address_id: add5.id)

add6 = Address.create!(line_1: '1819 E Prospect Rd', city: 'Ashtabula',
                        state: 'OH', zip: '44004', name: 'CVS', user_id: user.id)
SizeEstimate.create!(address_id: add6.id)
ServiceRequest.create!(address_id: add6.id, service_ids: Service.pluck(:id))
ServiceDelivery.create!(address_id: add6.id)
