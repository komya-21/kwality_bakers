class CreateEmpWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :emp_works do |t|
      t.references :employee, foreign_key: true
      t.string :in_time
      t.string :out_time
      t.string :work_hours
      t.date :date

      t.timestamps
    end
  end
end
