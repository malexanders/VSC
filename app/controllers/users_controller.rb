class UsersController < ApplicationController

	# Returns all items for which the selected user is the seller
	def seller_items
		User.find(params[:id]).seller_items
  end

end
