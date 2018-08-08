class CreateWorkorders < ActiveRecord::Migration[5.1]
  def change
    create_table :workorders do |t|

      t.timestamps
    end
  end
end
