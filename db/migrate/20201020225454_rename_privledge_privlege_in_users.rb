class RenamePrivledgePrivlegeInUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :privledge_id, :privlege_id
  end
end
