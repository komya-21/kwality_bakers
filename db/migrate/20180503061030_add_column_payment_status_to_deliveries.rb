class AddColumnPaymentStatusToDeliveries < ActiveRecord::Migration[5.1]
  def change
        add_column :deliveries, :payment_status, :boolean, :default => false
  end
end
