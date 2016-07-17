# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create([{ title: 'books' }, { title: 'movies' }, { title: 'tools' }])

users = User.create([{
                      name: 'Matthew',
                      latitude: Faker::Address.latitude,
                      longtitude: Faker::Address.longitude
                    },
                     {
                       name: 'Jess',
                       latitude: Faker::Address.latitude,
                       longtitude: Faker::Address.longitude
                     }
          ])

5.times do
  Item.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.number(5),
    status: 'available',
    published_date: Faker::Time.backward(14),
    seller_id: users[0].id
  )
end

5.times do
  Item.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.number(5),
    status: 'sold',
    published_date: Faker::Date.backward(14),
    seller_id: users[0].id
  )
end

5.times do
  Item.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.number(5),
    status: 'sold',
    published_date: Faker::Date.backward(14),
    seller_id: users[1].id
  )
end

5.times do
  Item.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.number(5),
    status: 'banned',
    published_date: Faker::Date.backward(14),
    seller_id: users[0].id
  )
end

items = Item.all

items.each do |item|
  item.categorizations.create(
    category_id: rand(1..3)
  )
end
