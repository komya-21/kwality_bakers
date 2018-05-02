class AddColumnToDeliveries < ActiveRecord::Migration[5.1]
  def change
    add_column :deliveries, :add_price, :string
    add_column :deliveries, :remaining_price, :string
  end
end
