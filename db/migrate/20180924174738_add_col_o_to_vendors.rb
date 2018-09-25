class AddColOToVendors < ActiveRecord::Migration[5.1]
  def change
    add_column :vendors, :opening_balance, :string
  end
end
