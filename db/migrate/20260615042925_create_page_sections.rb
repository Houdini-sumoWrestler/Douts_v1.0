class CreatePageSections < ActiveRecord::Migration[8.1]
  def change
    create_table :page_sections do |t|
      t.references :page, null: false, foreign_key: true
      t.string :title
      t.string :section_key
      t.text :content
      t.string :image_url
      t.string :button_text
      t.string :button_url
      t.integer :position
      t.boolean :visible

      t.timestamps
    end
  end
end
