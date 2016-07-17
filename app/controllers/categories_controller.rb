class CategoriesController < ApplicationController
  def available_items
    @available_items = Category.find(params[:id]).items.available
  end
end
