class AddColumnToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :employee_type, :string
  end
end
