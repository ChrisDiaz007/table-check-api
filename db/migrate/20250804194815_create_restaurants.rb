class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :address
      t.string :prefecture
      t.string :district
      t.text :description
      t.string :phone_number
      t.string :website
      t.integer :total_tables
      t.integer :followers_count, default: 0
      t.integer :favorites_count, default: 0

      t.timestamps
    end
  end
end
