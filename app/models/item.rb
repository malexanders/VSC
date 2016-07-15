class Item < ActiveRecord::Base
	belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
	enum status: {available: 0, pending: 1, sold: 2, expired: 3, banned: 4 }
	scope :category, -> (category) { where category: category}

end
