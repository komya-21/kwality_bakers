class AddColumnToWorkorder < ActiveRecord::Migration[5.1]
  def change
    add_column :workorders, :date, :date
  end
end
