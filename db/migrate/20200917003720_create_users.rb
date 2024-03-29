# frozen_string_literal: true

# CreateUsers
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :uin
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :committee
      t.string :subcommittee
      t.integer :total_points
      t.integer :meeting_points
      t.integer :event_points
      t.integer :misc_points
      t.boolean :admin
      t.boolean :student

      t.timestamps
    end
  end
end
