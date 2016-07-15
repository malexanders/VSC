class Item < ActiveRecord::Base
	belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
	has_and_belongs_to_many :categories
	enum status: {available: 0, pending: 1, sold: 2, expired: 3, banned: 4 }
	scope :category, -> (category) { where category: category}

end
