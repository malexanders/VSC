class User < ActiveRecord::Base
	has_many :items, :class_name => 'Item', :foreign_key => 'seller_id'
end
