class CreateEmployeesWorkorders < ActiveRecord::Migration[5.1]
  def change
    create_table :employees_workorders do |t|
      t.string :starttime
      t.string :endtime
      t.references :employee, foreign_key: true
      t.references :workorder, foreign_key: true

      t.timestamps
    end
  end
end
