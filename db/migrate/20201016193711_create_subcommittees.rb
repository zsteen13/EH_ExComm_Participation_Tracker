# frozen_string_literal: true

class CreateSubcommittees < ActiveRecord::Migration[6.0]
  def change
    create_table :subcommittees do |t|
      t.integer :subcommittee_id
      t.string :subcommittee
      t.integer :point_threshold

      t.timestamps
    end
  end
end
