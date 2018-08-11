class AddColumnsToWorkorders < ActiveRecord::Migration[5.1]
  def change
    add_column :workorders, :name1, :string
    add_column :workorders, :name2, :string
    add_column :workorders, :name3, :string
    add_column :workorders, :name4, :string
    add_column :workorders, :name5, :string
  end
end
