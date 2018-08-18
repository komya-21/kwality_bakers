class AddColumnToEmployeesWorkorders < ActiveRecord::Migration[5.1]
  def change
    add_column :employees_workorders, :status, :string
  end
end
