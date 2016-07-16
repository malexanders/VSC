FactoryGirl.define do
  factory :category do
    title "MyString"
		
		factory :category_with_item do
			after(:create) do |category|
				category.items << FactoryGirl.create(:item)
			end
		end
  end
end
