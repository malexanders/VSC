require 'rails_helper'
require 'spec_helper'

RSpec.describe CategoryController, type: :controller do
let!(:category) { FactoryGirl.create(:category_with_item) }

  describe "GET #available_items" do
    it "returns http success" do
      get :available_items
      expect(response).to have_http_status(:success)
    end
  end

end
