class CategoriesItemsJoin < ActiveRecord::Migration
  def self.up
		create_table 'categories_items', :id => false do |t|
			t.column 'category_id', :integer
			t.column 'item_id', :integer
		end
  end

	def self.down
		drop_table 'categories_items'
	end



end
