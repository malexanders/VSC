require 'rails_helper'
require 'spec_helper'

RSpec.describe ItemsController, type: [:controller] do
  # To render jbuilder views
  render_views

  user = FactoryGirl.create(:user)
  let!(:items) { FactoryGirl.create_list(:item, 10, seller: user) }
	let!(:item_banned) {FactoryGirl.create(:item, status: "banned")}
	let(:json) { JSON.parse(response.body) }

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
		# Makes sure neither array is empty
    # Expects the two arrays of ids to be equal
    it 'returns a list of all items' do
      db_items = JSON.parse(Item.all.to_json)

      response_items_ids = json.map { |item| item['id'] }
      db_items_ids = db_items.map { |item| item['id'] }

			expect(response_items_ids.length > 0 && db_items_ids.length > 0).to eq(true)
      expect(response_items_ids).to eq(db_items_ids)
    end

		it 'does not return fields seller_name and published_date for banned items' do
			banned_item = json.select{|item| item["status"] == "banned"}

			expect(banned_item[0]["seller_name"]).to eq(nil)			
			expect(banned_item[0]["published_date"]).to eq(nil)
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
      response_item = json
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
