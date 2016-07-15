require 'rails_helper'

RSpec.describe Item, type: :model do

	describe "Items API" do
		it "sends all items" do
			create_list(:item, 10)

			get '/items'

			expect(response.length).to eq(10)
		end
	end
end
