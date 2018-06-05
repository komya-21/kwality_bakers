class AddColumnsToInwardProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :inward_products, :after_inward, :string
    add_column :inward_products, :after_delivery_string, :string
  end
end
