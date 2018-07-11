class AddColumnToDeliveryInward < ActiveRecord::Migration[5.1]
  def change
    add_column :delivery_inwards, :price, :string
  end
end
