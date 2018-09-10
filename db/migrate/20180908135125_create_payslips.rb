class CreatePayslips < ActiveRecord::Migration[5.1]
  def change
    create_table :payslips do |t|
      t.references :employee, foreign_key: true
      t.references :earning, foreign_key: true
      t.references :deduction, foreign_key: true
      t.date :date
      t.string :basic_salary

      t.timestamps
    end
  end
end
