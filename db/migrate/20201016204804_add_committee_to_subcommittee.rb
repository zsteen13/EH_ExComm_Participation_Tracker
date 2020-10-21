# frozen_string_literal: true

# adding subcommittee id to committees table
class AddCommitteeToSubcommittee < ActiveRecord::Migration[6.0]
  def change
    add_column :subcommittees, :committee, :integer
  end
end
