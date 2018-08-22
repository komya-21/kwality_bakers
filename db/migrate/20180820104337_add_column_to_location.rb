class AddColumnToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :email, :string
  end
end
