class ItemsController < ApplicationController
	include ItemsHelper
  # Returns full list of items
  def index
    @items = fetch_items
  end

  # Returns details for a single item
  def show
    @item = Item.find(params[:id])
  end
end
