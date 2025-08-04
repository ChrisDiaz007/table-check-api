class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.references :table, null: false, foreign_key: true
      t.datetime :reservation_time, null: false
      t.integer :party_size, null: false
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
