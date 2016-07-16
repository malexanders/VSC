FactoryGirl.define do
  factory :user do
    name "MyString"
    latitude "9.99"
    longtitude "9.99"

		factory :user_with_item do
			after(:create) do |user|
				create_list(:item, 5, status: "sold", seller: user)
			end
		end

  end
end
