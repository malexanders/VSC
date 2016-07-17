FactoryGirl.define do
  factory :category do
    title 'MyString'

    factory :category_with_item do
      after(:create) do |category|
        category.items << FactoryGirl.create_list(:item, 10, status: 0)
        category.items << FactoryGirl.create_list(:item, 3, status: 2)
      end
    end
  end
end
