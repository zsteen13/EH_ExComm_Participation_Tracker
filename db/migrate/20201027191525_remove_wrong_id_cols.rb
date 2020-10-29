# frozen_string_literal: true

# removing these columns as id column is autogenerated
class RemoveWrongIdCols < ActiveRecord::Migration[6.0]
  def change
    remove_column :committees, :committee_id
    remove_column :subcommittees, :subcommittee_id
  end
end