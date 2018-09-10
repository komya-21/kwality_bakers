class AddColumnToPayslip < ActiveRecord::Migration[5.1]
  def change
    add_column :payslips, :gross_salary, :string
    add_column :payslips, :net_salary, :string
  end
end
