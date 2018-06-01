class CreateCurrentInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :current_inventories do |t|
      t.string :current_quantity
      t.references :inward_product, foreign_key: true
      t.references :delivery_inward, foreign_key: true

      t.timestamps
    end
  end
end
