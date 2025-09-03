class MakeTableIdNullableOnReservations < ActiveRecord::Migration[7.1]
  def up
    change_column_null :reservations, :table_id, true
  end

  def down
    change_column_null :reservations, :table_id, false
  end
end
