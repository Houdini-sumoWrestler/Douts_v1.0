class AddMembershipFieldsToMembers < ActiveRecord::Migration[8.1]
  def change
    add_column :members, :membership_class, :string
    add_column :members, :code_of_conduct_accepted, :boolean
    add_column :members, :terms_accepted, :boolean
  end
end
