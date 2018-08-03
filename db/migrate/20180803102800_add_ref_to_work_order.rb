class AddRefToWorkOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :work_orders, :furniture, foreign_key: true
  end
end
