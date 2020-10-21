# frozen_string_literal: true

class DropPrivledgesTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :privledges
  end
end
