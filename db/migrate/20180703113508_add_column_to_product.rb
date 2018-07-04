class AddColumnToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :delivery_quantity, :string
  end
end
