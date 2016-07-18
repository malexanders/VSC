FactoryGirl.define do
  factory :category do
    title 'MyString'

    factory :category_with_available_items do
      after(:create) do |category|
        category.items << FactoryGirl.create_list(:item, 10, status: 0)
        category.items << FactoryGirl.create_list(:item, 1, status: 4)
      end
    end
  end
end
