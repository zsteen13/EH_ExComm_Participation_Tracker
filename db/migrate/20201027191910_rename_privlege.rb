# frozen_string_literal: true

# Renamed Privlege to Privilege
class RenamePrivlege < ActiveRecord::Migration[6.0]
  def change
    rename_table :privleges, :privileges
    rename_column :privileges, :privlege, :privilege
    remove_column :privileges, :privlege_id
  end
end
