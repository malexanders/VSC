class ItemsController < ApplicationController

	# Returns full list of items
	def index
		@items = Item.all
		render json: @items
	end

	# Returns details for a single item
	def show
		@item = Item.find(params[:id])
		render json: @item
	end

end
