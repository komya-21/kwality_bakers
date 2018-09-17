class CreateTransactionDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :transaction_details do |t|
      t.date :date
      t.references :inward, foreign_key: true
      t.boolean :payment_status
      t.string :payment_mode
      t.string :bank_name
      t.string :cheque_no

      t.timestamps
    end
  end
end
