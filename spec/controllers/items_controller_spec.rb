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

		it "returns all items" do
			parsed_body = JSON.parse(response.body)
			all_items = Item.all
			expect(parsed_body.length).to eq(all_items.length)
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
	end

end
