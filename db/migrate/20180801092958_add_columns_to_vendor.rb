class AddColumnsToVendor < ActiveRecord::Migration[5.1]
  def change
    add_column :vendors, :email, :string
    add_column :vendors, :password, :string
  end
end
