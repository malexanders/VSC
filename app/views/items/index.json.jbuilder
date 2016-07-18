json.array! @items do |item|
	json.id	item.id
	json.title	item.title
	json.description	item.description
	json.category	item.categories.length > 0 ? item.categories.first.title : 'none'
	json.price	item.price / 100.0
	json.status	item.status

	unless item.banned?
		json.published_date	item.published_date.utc.to_s
		json.seller_name	item.seller.name
	end

	json.seller_latitude	item.seller.latitude.to_f
	json.seller_longtitude	item.seller.longtitude.to_f
end

# Uncomment when using redis for caching
# json is being built in items_helper.rb

# json.array! @items do |item|
# 	# db_item = Item.find(item["id"])
#
#   json.id	item["id"]
#   json.title	item["title"]
#   json.description	item["description"]
#   json.category	item["category"]
#   json.price	item["price"] / 100.0
#   json.status	item["status"]
#
#   unless item["status"] == "banned"
#     json.published_date	item["published_date"]
#     json.seller_name	item["seller_name"]
#   end
#
#   json.seller_latitude	item["seller_latitude"]
#   json.seller_longtitude	item["seller_longtitude"]
# end
