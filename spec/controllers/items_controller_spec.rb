require 'rails_helper'
require 'spec_helper'

RSpec.describe ItemsController, type: [:controller] do
	let!(:item) { FactoryGirl.create(:item) }

	describe "GET #index" do
		before { get :index }
		it "returns http success" do
			expect(response).to have_http_status(:success)
		end

		it "responds with json" do
			expect(response.content_type).to eq("application/json")
		end
	end

	describe "GET #show" do
		before {get :show, id: item.id}

		it "returns http success" do
			expect(response).to have_http_status(:success)
		end

		it "responds with json" do
			expect(response.content_type).to eq("application/json")
		end
	end

end
