class AddColumnToDeliveryInwards < ActiveRecord::Migration[5.1]
  def change
    add_column :delivery_inwards, :gst, :integer
    add_column :delivery_inwards, :total, :string
  end
end
