class UsersController < ApplicationController
  # Returns all items for which the selected user is the seller
  # and the item has been sold.
  def sold_items
    @sold_items = User.find(params[:id]).seller_items.sold
  end
end
