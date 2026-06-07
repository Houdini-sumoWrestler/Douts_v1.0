class CreateEventAssets < ActiveRecord::Migration[8.1]
  def change
    create_table :event_assets do |t|
      t.references :event, null: false, foreign_key: true
      t.references :asset, null: false, foreign_key: true
      t.integer :quantity_available
      t.decimal :price

      t.timestamps
    end
  end
end
