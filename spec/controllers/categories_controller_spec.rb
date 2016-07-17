require 'rails_helper'
require 'spec_helper'

RSpec.describe CategoriesController, type: :controller do
	# To render jbuilder views
  render_views

	let!(:category) { FactoryGirl.create(:category_with_available_items) }
	let!(:category2) { FactoryGirl.create(:category_with_available_items) }
	let(:json) { JSON.parse(response.body) }

  describe 'GET #available_items' do
    before { get :available_items, id: category.id }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'responds with json' do
      expect(response.content_type).to eq('application/json')
    end

		it 'returns only items where status equals available' do
			answer = json.all?{|item| item["status"] == "available"}
			expect(answer).to eq(true)
		end

		# Questioning this one.
		# Refactor to make more readable and efficient
		it 'returns only available items that are categorized under category' do
			db_items = Item.joins(:categories).where(categories: {id: category.id}, status: 0)
			db_items_ids = db_items.map(&:id)
			response_items_ids = json.map{|item| item["id"]}
			expect(response_items_ids).to eq(db_items_ids)
		end

		# Parses response.body
		# Pulls all available items from test db
		# Iterates through response_items and db_items
		# Extractes ids of all objects in each collection and passes them into separate arrays
		# Makes sure neither array is empty
		# Expects the two arrays of ids to be equal
    it 'returns a list of available items for a particular category' do
      db_items = JSON.parse(Category.find(category.id).items.available.to_json)

      response_items_ids = json.map { |item| item['id'] }
      db_items_ids = db_items.map { |item| item['id'] }

			expect(response_items_ids.length > 0 && db_items_ids.length > 0).to eq(true)
      expect(response_items_ids).to eq(db_items_ids)
    end

		it 'returns all required fields' do
			response_item = json[0]
			db_item = Item.find(json[0]["id"].to_i)

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
