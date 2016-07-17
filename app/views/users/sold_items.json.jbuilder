json.array! @sold_items do |item|
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
