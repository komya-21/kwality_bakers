class CreateReturns < ActiveRecord::Migration[5.1]
  def change
    create_table :returns do |t|
      t.string :date_of_return
      t.string :invoice_number
      t.references :vendor, foreign_key: true
      t.references :inward_product, foreign_key: true
      t.string :return_quantity
      t.string :purpose
      t.string :receipt_no
      t.string :return_type

      t.timestamps
    end
  end
end
