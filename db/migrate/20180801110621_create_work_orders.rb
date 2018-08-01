class CreateWorkOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :work_orders do |t|
      t.float :width
      t.float :depth
      t.float :height
      t.bigint :quantity
      t.references :color, foreign_key: true
      t.string :side
      t.float :skirting
      t.integer :horizontal
      t.integer :vertical
      t.integer :center
      t.string :total

      t.timestamps
    end
  end
end
