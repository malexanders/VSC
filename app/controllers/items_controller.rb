class ItemsController < ApplicationController
  include ItemsHelper
  # Returns full list of items
  def index
		# Uncomment when using redis for caching
    # @items = fetch_items

		@items = Item.all
  end

  # Returns details for a single item
  def show
    @item = Item.find(params[:id])
  end
end
