class AddReferenceToWorkorders < ActiveRecord::Migration[5.1]
  def change
    add_reference :workorders, :color, foreign_key: true
  end
end
