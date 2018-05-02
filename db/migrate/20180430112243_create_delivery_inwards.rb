class CreateDeliveryInwards < ActiveRecord::Migration[5.1]
  def change
    create_table :delivery_inwards do |t|
      t.references :delivery, foreign_key: true
      t.references :inward_product, foreign_key: true
      t.string :rate
      t.string :quantity
      t.string :rem_quantity
      t.string :qty
      t.string :total_amt

      t.timestamps
    end
  end
end
