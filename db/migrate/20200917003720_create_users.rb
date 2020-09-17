class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.int :uin
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :committee
      t.string :subcommittee
      t.int :total_points
      t.int :meeting_points
      t.int :event_points
      t.int :misc_points
      t.boolean :admin

      t.timestamps
    end
  end
end
