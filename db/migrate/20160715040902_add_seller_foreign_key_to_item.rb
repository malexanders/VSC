class AddSellerForeignKeyToItem < ActiveRecord::Migration
  def change
		add_reference :items, :user, index: true, foreign_key: true, column: "seller_id"
  end
end
