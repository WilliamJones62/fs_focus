class AddEmployeeNameToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :Employee_Name, :string
  end
end
