class AddColPToInwardProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :inward_products, :price, :float
  end
end
