class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :meeting_room, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.date :date
      t.timestamps
    end
  end
end
