# frozen_string_literal: true

class AddUniqueIndexToUserToActivities < ActiveRecord::Migration[6.0]
  def change
    add_index :user_to_activities, %i[uin activity_id], unique: true
  end
end
