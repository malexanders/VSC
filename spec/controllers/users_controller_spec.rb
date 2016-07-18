require 'rails_helper'
require 'spec_helper'

RSpec.describe UsersController, type: [:controller] do
  render_views

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
      answer = json.all? { |item| item['status'] == 'sold' }
      expect(answer).to eq(true)
    end

    it 'returns only items where seller_id equals seller.id' do
      response_items_ids = json.map { |item| item['id'] }
      answer = response_items_ids.all? { |id| Item.find(id).seller_id == seller.id }
      expect(answer).to eq(true)
    end

    it 'returns a list of all sold items for a particular seller' do
      parsed_body = JSON.parse(response.body)
      items_sold = Item.where(seller: seller).sold
      expect(parsed_body.length).to eq(items_sold.length)
    end

    it 'returns all required fields' do
      response_item = json[0]
      db_item = Item.find(json[0]['id'].to_i)

      expect(response_item['id']).to eq db_item.id
      expect(response_item['title']).to eq db_item.title
      expect(response_item['description']).to eq db_item.description
      expect(response_item['category']).to eq db_item.categories.length > 0 ? db_item.categories.first.title : 'none'
      expect(response_item['price']).to eq db_item.price / 100.0
      expect(response_item['status']).to eq db_item.status
      expect(response_item['published_date']).to eq db_item.published_date.utc.to_s
      expect(response_item['seller_name']).to eq db_item.seller.name
      expect(response_item['seller_latitude']).to eq db_item.seller.latitude.to_f
      expect(response_item['seller_longtitude']).to eq db_item.seller.longtitude.to_f
    end
  end
end
