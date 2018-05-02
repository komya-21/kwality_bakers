class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      t.string :invoice_no
      t.date :date
      t.references :vendor, foreign_key: true
      t.string :bill_checked_by

      t.timestamps
    end
  end
end
