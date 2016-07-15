require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #items" do
    it "returns http success" do
			user = FactoryGirl.create(:user)
			get "users/#{user.id}/sold_items"
      expect(response).to have_http_status(:success)
    end
  end

end
