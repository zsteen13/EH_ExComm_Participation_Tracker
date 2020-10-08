class CreateUserToActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :user_to_activities do |t|
      t.integer :uin
      t.integer :activity_id

      t.timestamps
    end
  end
end