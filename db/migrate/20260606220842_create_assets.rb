class CreateAssets < ActiveRecord::Migration[8.1]
  def change
    create_table :assets do |t|
      t.string :name
      t.integer :quantity
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
