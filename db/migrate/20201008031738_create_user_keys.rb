# frozen_string_literal: true

class CreateUserKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :user_keys do |t|
      t.string :key, null: false
      t.belongs_to :user, null: false
    end
  end
end
