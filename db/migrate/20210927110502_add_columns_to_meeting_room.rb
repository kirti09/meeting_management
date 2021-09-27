class AddColumnsToMeetingRoom < ActiveRecord::Migration[6.1]
  def change
    # is_available attribute signifies whether room is available for booking or not. By defalut is it set as available.
    add_column :meeting_rooms, :is_available, :boolean, default: true
    add_column :meeting_rooms, :has_wifi, :boolean, default: false
    add_column :meeting_rooms, :has_projector, :boolean, default: false
  end
end
