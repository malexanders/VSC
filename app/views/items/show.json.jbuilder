json.array! @items do |item|
	json.title 							item.title
	json.description 				item.description
	json.category						item.categories.first.title
	json.price							item.price / 100.0
	json.status							item.status

	if !item.banned?
		json.published_date			item.published_date
		json.seller_name				item.seller.name
	end

	json.seller_latitude		item.seller.latitude.to_f
	json.seller_longtitude	item.seller.longtitude.to_f
end
