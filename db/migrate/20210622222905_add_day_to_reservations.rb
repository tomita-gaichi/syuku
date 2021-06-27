class AddDayToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :day, :integer
  end
end
