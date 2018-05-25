class AddColumnToInwardProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :inward_products, :total_quantity, :integer
  end
end
