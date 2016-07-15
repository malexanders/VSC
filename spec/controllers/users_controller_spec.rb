require 'rails_helper'
require 'spec_helper'

RSpec.describe UsersController, type: [:controller] do
	let!(:user) { FactoryGirl.create(:user) }

  describe "GET #sold_items" do
		before { get :sold_items, id: user.id }

		it "returns http success" do
      expect(response).to have_http_status(:success)
    end

		it "responds with json" do
			expect(response.content_type).to eq("application/json")
		end
  end

end
