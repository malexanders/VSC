require 'rails_helper'
require 'spec_helper'

RSpec.describe CategoriesController, type: :controller do
let!(:category) { FactoryGirl.create(:category_with_item) }

  describe "GET #available_items" do
		before { get :available_items, id: category.id}
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

		it "responds with json" do
			expect(response.content_type).to eq("application/json")
		end

		it "returns a list of available items for a particular category" do
			parsed_body = JSON.parse(response.body)
			parsed_items = JSON.parse(Category.find(category.id).items.available.to_json)
			expect(parsed_items).to eq(parsed_body)
		end
  end

end
