class AddFocusItemsRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :focus_items_role, :string
  end
end
