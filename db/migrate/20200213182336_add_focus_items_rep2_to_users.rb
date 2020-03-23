class AddFocusItemsRep2ToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :focus_items_rep2, :string
  end
end
