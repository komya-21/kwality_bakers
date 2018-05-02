class AddTotalColToDeliveries < ActiveRecord::Migration[5.1]
  def change
    add_column :deliveries, :total_to_pay, :string
  end
end
