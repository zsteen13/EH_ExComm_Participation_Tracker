class AddUniqueIndexToUserToActivities < ActiveRecord::Migration[6.0]
  def change
    add_index :user_to_activities, [:uin, :activity_id], unique: true
  end
end
