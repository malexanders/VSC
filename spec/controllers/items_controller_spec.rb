require 'rails_helper'
require 'spec_helper'

RSpec.describe ItemsController, type: [:controller] do
	let!(:item) { FactoryGirl.create_list(:item, 10) }

	describe "GET #index" do
		before { get :index }
		it "returns http success" do
			expect(response).to have_http_status(:success)
		end

		it "responds with json" do
			expect(response.content_type).to eq("application/json")
		end

		it "returns a list of all items" do
			parsed_body = JSON.parse(response.body)
			all_items = JSON.parse(Item.all.to_json)
			expect(all_items).to eq(parsed_body)
		end
	end

	describe "GET #show" do
		before {get :show, id: item[0].id}

		it "returns http success" do
			expect(response).to have_http_status(:success)
		end

		it "responds with json" do
			expect(response.content_type).to eq("application/json")
		end

		it "returns details for a specific item" do
			parsed_body = JSON.parse(response.body)
			parsed_item = JSON.parse(item[0].to_json)
			expect(parsed_item).to eq(parsed_body)
		end
	end

end
