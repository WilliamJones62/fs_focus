class CreateCustomerShiptos < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_shiptos do |t|
      t.string :cust_code
      t.string :shipto_code
      t.string :bus_name
      t.string :acct_manager
      t.boolean :default_flag

      t.timestamps
    end
  end
end
