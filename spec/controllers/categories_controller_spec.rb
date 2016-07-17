require 'rails_helper'
require 'spec_helper'

RSpec.describe CategoriesController, type: :controller do
	# To render jbuilder views
  render_views

	let!(:category) { FactoryGirl.create(:category_with_item) }
	let(:json) { JSON.parse(response.body) }

  describe 'GET #available_items' do
    before { get :available_items, id: category.id }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'responds with json' do
      expect(response.content_type).to eq('application/json')
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

		it 'returns only items with status available' do
			answer = json.all?{|item| item["status"] == "available"}
			expect(answer).to eq(true)
		end

  end
end
