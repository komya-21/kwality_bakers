class AddColToInwardProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :inward_products, :width, :float
    add_column :inward_products, :height, :float
    add_column :inward_products, :category, :string
    add_reference :inward_products, :color, foreign_key: true
  end
end
