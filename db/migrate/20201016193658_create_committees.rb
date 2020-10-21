# frozen_string_literal: true

class CreateCommittees < ActiveRecord::Migration[6.0]
  def change
    create_table :committees do |t|
      t.integer :committee_id
      t.string :committee
      t.integer :point_threshold
      t.string :head_first_name
      t.string :head_last_name
      t.string :email

      t.timestamps
    end
  end
end
