class CreateInwardProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :inward_products do |t|
      t.string :quantity
      t.references :product, foreign_key: true
      t.references :inward, foreign_key: true

      t.timestamps
    end
  end
end
