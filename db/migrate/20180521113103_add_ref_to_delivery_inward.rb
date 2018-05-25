class AddRefToDeliveryInward < ActiveRecord::Migration[5.1]
  def change
    add_reference :delivery_inwards, :product, foreign_key: true
  end
end
