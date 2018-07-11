class AddColumnToVendor < ActiveRecord::Migration[5.1]
  def change
    add_column :vendors, :vendor_type, :string
  end
end
