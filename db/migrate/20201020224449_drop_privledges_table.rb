class DropPrivledgesTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :privledges
  end
end
