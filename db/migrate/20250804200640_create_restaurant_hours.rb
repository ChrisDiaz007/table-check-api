class CreateRestaurantHours < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurant_hours do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.integer :day_of_week, null: false
      t.time :opens_at, null: false
      t.time :closes_at, null: false

      t.timestamps
    end
  end
end
