class AddLunchDinnerAndAboutToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :lunch_price, :integer
    add_column :restaurants, :dinner_price, :integer
    add_column :restaurants, :about, :string
  end
end
