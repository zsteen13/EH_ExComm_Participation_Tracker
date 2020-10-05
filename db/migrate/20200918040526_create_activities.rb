class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :_type
      t.string :date
      t.numeric :point_value
      t.string :description
      t.numeric :num_rsvp

      t.timestamps
    end
  end
end
