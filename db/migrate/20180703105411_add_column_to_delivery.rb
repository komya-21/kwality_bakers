class AddColumnToDelivery < ActiveRecord::Migration[5.1]
  def change
    add_column :deliveries, :comission, :string
  end
end
