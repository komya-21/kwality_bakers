class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :contact_no
      t.string :email
      t.string :address
      t.string :employee_no

      t.timestamps
    end
  end
end
