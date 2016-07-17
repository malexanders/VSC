require 'rails_helper'
require 'spec_helper'

RSpec.describe UsersController, type: [:controller] do
  let!(:seller) { FactoryGirl.create(:seller_with_items) }
	let(:json) { JSON.parse(response.body) }

  describe 'GET #sold_items' do
    before { get :sold_items, id: seller.id }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'responds with json' do
      expect(response.content_type).to eq('application/json')
    end

		it 'returns only items where status equals sold' do
			answer = json.all?{|item| item["status"] == "sold"}
			expect(answer).to eq(true)
		end

		it 'returns only items where seller_id equals seller.id' do
			answer = json.all?{|item| item["seller_id"] == seller.id}
			expect(answer).to eq(true)
		end


    it 'returns a list of all sold items for a particular seller' do
      parsed_body = JSON.parse(response.body)
      items_sold = Item.where(seller: seller).sold
      expect(parsed_body.length).to eq(items_sold.length)
    end
  end
end
