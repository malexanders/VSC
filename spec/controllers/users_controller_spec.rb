require 'rails_helper'
require 'spec_helper'

RSpec.describe UsersController, type: [:controller] do
	let!(:user) { FactoryGirl.create(:user_with_items) }

  describe "GET #sold_items" do
		before { get :sold_items, id: user.id }

		it "returns http success" do
      expect(response).to have_http_status(:success)
    end

		it "responds with json" do
			expect(response.content_type).to eq("application/json")
		end

		it "shows only items sold" do
			parsed_body = JSON.parse(response.body)
			items_sold = Item.where(seller: user).sold

			expect(parsed_body.length).to eq(items_sold.length)
		end
  end

end
