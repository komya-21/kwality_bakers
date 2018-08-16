class AddColToInwardProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :inward_products, :unit, :string
  end
end
