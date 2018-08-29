class AddColToColor < ActiveRecord::Migration[5.1]
  def change
    add_column :colors, :light, :string
    add_column :colors, :dark, :string
  end
end
