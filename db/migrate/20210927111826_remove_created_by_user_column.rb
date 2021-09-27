class RemoveCreatedByUserColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :meeting_rooms, :created_by_user, :integer
  end
end
