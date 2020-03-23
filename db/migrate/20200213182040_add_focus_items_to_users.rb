class AddFocusItemsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :focus_items, :boolean
  end
end
