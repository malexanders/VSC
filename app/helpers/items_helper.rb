module ItemsHelper
	# Refactor
	def fetch_items
		items = $redis.get("items")

		if items.nil?
			items = []

			Item.all.each do |item|
				categories = item.categories
				json = {}
				json["id"] = item.id
				json["title"] = item.title
				json["description"] = item.description
				json["category"] = categories.length > 0  ? categories.first.title : 'none'
				json["price"] = item.price
				json["status"] = item.status
				json["published_date"] = item.published_date.utc.to_s
				json["seller_name"] = item.seller.name
				json["seller_latitude"] = item.seller.latitude.to_f
				json["seller_longitude"] = item.seller.longtitude.to_f
				items << json
			end
			json_items = items.to_json
			$redis.set("items", json_items)
			items = $redis.get("items")
		end

		@items = JSON.load items
	end
end
