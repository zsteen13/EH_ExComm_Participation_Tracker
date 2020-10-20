class AddCommitteeToSubcommittee < ActiveRecord::Migration[6.0]
  def change
    add_column :subcommittees, :committee, :integer
  end
end
