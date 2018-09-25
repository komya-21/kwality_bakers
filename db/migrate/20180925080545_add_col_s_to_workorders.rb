class AddColSToWorkorders < ActiveRecord::Migration[5.1]
  def change
    add_column :workorders, :site_name, :string
  end
end
