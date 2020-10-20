class ChangeCommitteeSubcommitteeToRefs < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :committee, :integer
    change_column :users, :subcommittee, :integer
  end
end
