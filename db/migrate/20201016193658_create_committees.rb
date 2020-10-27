# frozen_string_literal: true

# creating committees table
class CreateCommittees < ActiveRecord::Migration[6.0]
  def change
    create_table :committees, id: false, primary_key: :committee_id do |t|
      t.primary_key :committee_id
      t.string :committee
      t.integer :point_threshold
      t.string :head_first_name
      t.string :head_last_name
      t.string :email

      t.timestamps
    end
  end
end
