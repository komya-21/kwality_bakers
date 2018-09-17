class AddColRToInwards < ActiveRecord::Migration[5.1]
  def change
    add_column :inwards, :total_to_pay, :float
    add_column :inwards, :add_price, :integer
    add_column :inwards, :rem_price, :integer
  end
end
