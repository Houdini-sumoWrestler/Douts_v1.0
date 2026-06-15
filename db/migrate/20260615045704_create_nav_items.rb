class CreateNavItems < ActiveRecord::Migration[8.1]
  def change
    create_table :nav_items do |t|
      t.string :title
      t.string :url
      t.integer :position
      t.boolean :visible, default: true
      t.references :parent, null: true, foreign_key: { to_table: :nav_items }

      t.timestamps
    end
  end
end