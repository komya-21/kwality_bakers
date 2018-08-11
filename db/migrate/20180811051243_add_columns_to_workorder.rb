class AddColumnsToWorkorder < ActiveRecord::Migration[5.1]
  def change
    add_column :workorders, :approve, :boolean
    
  end
end
