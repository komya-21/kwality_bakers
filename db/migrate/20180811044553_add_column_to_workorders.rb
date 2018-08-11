class AddColumnToWorkorders < ActiveRecord::Migration[5.1]
  def change
    add_column :workorders, :order_no, :string
  end
end
