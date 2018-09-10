class CreateEmployeePayrolls < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_payrolls do |t|
      t.string :category_name
      t.string :percentage
      t.boolean :is_deduction

      t.timestamps
    end
  end
end
