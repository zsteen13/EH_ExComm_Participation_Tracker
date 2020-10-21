# frozen_string_literal: true

class CreatePrivledges < ActiveRecord::Migration[6.0]
  def change
    create_table :privledges do |t|
      t.integer :privledge_id
      t.string :privledge

      t.timestamps
    end
  end
end
