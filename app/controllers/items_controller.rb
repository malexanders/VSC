class ItemsController < ApplicationController
  # Returns full list of items
  def index
    @items = Item.all
		byebug
  end

  # Returns details for a single item
  def show
    @item = Item.find(params[:id])
  end
end
