class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.string :meeting_point
      t.string :location
      t.integer :capacity

      t.timestamps
    end
  end
end
