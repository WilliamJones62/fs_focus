class AddFocusItemsRep1ToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :focus_items_rep1, :string
  end
end
