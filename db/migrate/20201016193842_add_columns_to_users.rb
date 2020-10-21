# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :privledge_id, :integer
    add_column :users, :class_year, :integer
    add_column :users, :point_threshold, :integer
  end
end
