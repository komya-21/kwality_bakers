class AddRefToWorkorders < ActiveRecord::Migration[5.1]
  def change
    add_reference :workorders, :vendor, foreign_key: true
  end
end
