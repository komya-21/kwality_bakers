class AddRefToWorkorder < ActiveRecord::Migration[5.1]
  def change
    add_reference :workorders, :location, foreign_key: true
  end
end
