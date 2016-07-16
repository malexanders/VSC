require 'rails_helper'

RSpec.describe CategoryController, type: :controller do
let!(:category) { FactoryGirl.create(:category_with_items) }

  describe "GET #available_items" do
    it "returns http success" do
			byebug
      get :available_items
      expect(response).to have_http_status(:success)
    end
  end

end
