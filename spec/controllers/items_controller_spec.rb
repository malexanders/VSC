require 'rails_helper'
require 'spec_helper'

RSpec.describe ItemsController, type: [:controller] do
	# To render jbuilder views
	render_views

	user = FactoryGirl.create(:user)
	let!(:items) { FactoryGirl.create_list(:item, 10, seller: user) }

	describe "GET #index" do
		before { get :index }

		it "returns http success" do
			expect(response).to have_http_status(:success)
		end

		it "responds with json" do
			expect(response.content_type).to eq("application/json")
		end

		# Could make some improvements to this test
		# Presently, it only checks if the same number of objects are returned
		# From the db and the response
		it "returns a list of all items" do
			parsed_body = JSON.parse(response.body)
			all_items = JSON.parse(Item.all.to_json)
			expect(all_items.length).to eq(parsed_body.length)
		end
	end

	describe "GET #show" do
		before {get :show, id: items[0].id}

		it "returns http success" do
			expect(response).to have_http_status(:success)
		end

		it "responds with json" do
			expect(response.content_type).to eq("application/json")
		end

		it "returns details for a specific item" do
			returned_item = JSON.parse(response.body)
			item = items[0]

			expect(returned_item["id"]).to eq item.id
			expect(returned_item["title"]).to eq item.title
			expect(returned_item["description"]).to eq item.description
			expect(returned_item["category"]).to eq item.categories.length > 0 ? item.categories.first.title : "none"
			expect(returned_item["price"]).to eq item.price / 100.0
			expect(returned_item["status"]).to eq item.status
			expect(returned_item["published_date"]).to eq item.published_date.utc.to_s
			expect(returned_item["seller_name"]).to eq item.seller.name
			expect(returned_item["seller_latitude"]).to eq item.seller.latitude.to_f
			expect(returned_item["seller_longtitude"]).to eq item.seller.longtitude.to_f

		end
	end

end
