# frozen_string_literal: true

# CreateUserKeys
class CreateUserKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :user_keys, id: false do |t|
      t.string :key, null: false
      t.belongs_to :user, null: false
    end
  end
end
