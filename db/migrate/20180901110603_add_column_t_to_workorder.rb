class AddColumnTToWorkorder < ActiveRecord::Migration[5.1]
  def change
    add_column :workorders, :total_to_pay, :string
    add_column :workorders, :add_price, :string
    add_column :workorders, :rem_price, :string
  end
end
