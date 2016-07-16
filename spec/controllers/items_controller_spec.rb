require 'rails_helper'
require 'spec_helper'

RSpec.describe ItemsController, type: [:controller] do
	# To render jbuilder views
	render_views

	user = FactoryGirl.create(:user)
	let!(:item) { FactoryGirl.create_list(:item, 10, seller: user) }
	# before :each do
  # 	request.env["HTTP_ACCEPT"] = 'application/json'
	# end
	describe "GET #index" do

		before :each do
			request.env["HTTP_ACCEPT"] = 'application/json'
		 	get :index
		end
		it "returns http success" do
			expect(response).to have_http_status(:success)
		end

		it "responds with json" do
			expect(response.content_type).to eq("application/json")
		end

		# Could make some improvements to this test
		it "returns a list of all items" do
			parsed_body = JSON.parse(response.body)
			all_items = JSON.parse(Item.all.to_json)
			expect(all_items.length).to eq(parsed_body.length)
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
