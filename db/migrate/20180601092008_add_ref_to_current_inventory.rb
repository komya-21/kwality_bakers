class AddRefToCurrentInventory < ActiveRecord::Migration[5.1]
  def change
    add_reference :current_inventories, :product, foreign_key: true
  end
end
