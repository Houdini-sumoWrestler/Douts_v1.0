class CreateEventRegistrations < ActiveRecord::Migration[8.1]
  def change
    create_table :event_registrations do |t|
      t.references :event, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
