class AddColumnToInwardProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :inward_products, :updated_quantity, :string
  end
end
