class AddColumnToWorkOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :work_orders, :furniture_product, :string
    add_column :work_orders, :type, :string
  end
end
