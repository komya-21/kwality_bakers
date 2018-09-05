class AddColDToWorkorder < ActiveRecord::Migration[5.1]
  def change
    add_column :workorders, :dark_color, :string
    add_column :workorders, :light_color, :string
    add_column :workorders, :delivered, :boolean
  end
end
