class CreateDeductions < ActiveRecord::Migration[5.1]
  def change
    create_table :deductions do |t|
      t.references :employee_payroll, foreign_key: true

      t.timestamps
    end
  end
end
