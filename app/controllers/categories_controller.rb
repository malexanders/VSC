class CategoriesController < ApplicationController

	def available_items
		@available_items = Category.find(params[:id]).items.available
		render json: @available_items
  end
end
