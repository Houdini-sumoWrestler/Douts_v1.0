class CreateMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :members do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.date :membership_expiry_date
      t.string :emergency_contact_name
      t.string :emergency_contact_number
      t.integer :number_of_dives
      t.date :last_dive_date
      t.boolean :has_dive_certification

      t.timestamps
    end
  end
end
