module ItemsHelper

	def fetch_items
		@items = Item.all
	end

end
