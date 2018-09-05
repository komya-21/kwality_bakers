class AddColPToWorkorder < ActiveRecord::Migration[5.1]
  def change
    add_column :workorders, :payment_status, :boolean
  end
end
