require 'rails_helper'
require 'spec_helper'

RSpec.describe ItemsController, type: [:controller] do
  # To render jbuilder views
  render_views

  user = FactoryGirl.create(:user)
  let!(:items) { FactoryGirl.create_list(:item, 10, seller: user) }

  describe 'GET #index' do
    before { get :index }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'responds with json' do
      expect(response.content_type).to eq('application/json')
    end

    # Parses response.body
    # Pulls all items from test db
    # Iterates through response_items and db_items
    # Extractes ids of all objects in each collection and passes them into separate arrays
    # Expects the two arrays of ids to be equal
    it 'returns a list of all items' do
      response_items = JSON.parse(response.body)
      db_items = JSON.parse(Item.all.to_json)

      response_items_ids = response_items.map { |item| item['id'] }
      db_items_ids = db_items.map { |item| item['id'] }

      expect(parsed_body_ids).to eq(all_item_ids)
    end
  end

  describe 'GET #show' do
    before { get :show, id: items[0].id }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'responds with json' do
      expect(response.content_type).to eq('application/json')
    end

    # Parses response.body
    # Makes sure all required fields are present
    # Verifies that response_item and db_item attributes match
    # Had to manipulate the db_item attributes
    # Because I manipulated some data in the jbuilder template
    it 'returns details for a specific item' do
      response_item = JSON.parse(response.body)
      db_item = items[0]
      expect(response_item['id']).to eq db_item.id
      expect(response_item['title']).to eq db_item.title
      expect(response_item['description']).to eq db_item.description
      expect(response_item['category']).to eq db_item.categories.length > 0 ? item.categories.first.title : 'none'
      expect(response_item['price']).to eq db_item.price / 100.0
      expect(response_item['status']).to eq db_item.status
      expect(response_item['published_date']).to eq db_item.published_date.utc.to_s
      expect(response_item['seller_name']).to eq db_item.seller.name
      expect(response_item['seller_latitude']).to eq db_item.seller.latitude.to_f
      expect(response_item['seller_longtitude']).to eq db_item.seller.longtitude.to_f
    end
  end
end
