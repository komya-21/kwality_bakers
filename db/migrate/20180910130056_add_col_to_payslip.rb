class AddColToPayslip < ActiveRecord::Migration[5.1]
  def change
    add_column :payslips, :month_year, :string
  end
end
