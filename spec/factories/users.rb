FactoryGirl.define do
  factory :user do
    name 'MyString'
    latitude '9.99'
    longtitude '9.99'

    factory :user_with_items do
      after(:create) do |user|
        create_list(:item, 5, status: 'sold', seller: user)
        create_list(:item, 15, status: 'available', seller: user)
      end
    end
  end
end
