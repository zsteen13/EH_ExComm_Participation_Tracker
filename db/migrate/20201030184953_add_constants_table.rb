# frozen_string_literal: true

# this is a table for storing constants
class AddConstantsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :constants do |t|
      t.string :name
      t.integer :value
    end
  end
end
