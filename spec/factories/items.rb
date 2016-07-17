FactoryGirl.define do
	before
  factory :item do
    title Faker::Commerce.product_name
    description Faker::Lorem.paragraph
    price Faker::Number.number(5)
    status "sold"
    published_date "2016-07-14 23:47:48 UTC"
		association :seller, factory: :user
  end
end
