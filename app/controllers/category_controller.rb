class CategoryController < ApplicationController

	def available_items
		@category = Category.find(params[:id]).items.available
  end
end
