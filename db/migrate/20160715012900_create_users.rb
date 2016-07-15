class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.decimal :latitude, :precision => 9, :scale => 6
      t.decimal :longtitude, :precision => 9, :scale => 6

      t.timestamps null: false
    end
  end
end
