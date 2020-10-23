class CreatePrivleges < ActiveRecord::Migration[6.0]
  def change
    create_table :privleges do |t|
      t.integer :privlege_id
      t.string :privlege

      t.timestamps
    end
  end
end
