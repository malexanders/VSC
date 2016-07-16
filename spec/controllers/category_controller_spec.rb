require 'rails_helper'

RSpec.describe CategoryController, type: :controller do

  describe "GET #available_items" do
    it "returns http success" do
      get :available_items
      expect(response).to have_http_status(:success)
    end
  end

end
