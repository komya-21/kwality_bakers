class AddColToWorkorders < ActiveRecord::Migration[5.1]
  def change
    add_column :workorders, :remove_photo1, :boolean

    add_column :workorders, :remove_photo2, :boolean

    add_column :workorders, :remove_photo3, :boolean

    add_column :workorders, :remove_photo4, :boolean

    add_column :workorders, :remove_photo5, :boolean
  end
end
