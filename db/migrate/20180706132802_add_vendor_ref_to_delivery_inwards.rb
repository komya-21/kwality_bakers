class AddVendorRefToDeliveryInwards < ActiveRecord::Migration[5.1]
  def change
    add_reference :delivery_inwards, :vendor, foreign_key: true
  end
end
