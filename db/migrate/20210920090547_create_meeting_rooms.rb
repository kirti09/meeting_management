class CreateMeetingRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :meeting_rooms do |t|
      t.string :name
      t.integer :capacity
      t.integer :created_by_user

      t.timestamps
    end
  end
end
