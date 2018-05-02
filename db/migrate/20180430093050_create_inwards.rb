class CreateInwards < ActiveRecord::Migration[5.1]
  def change
    create_table :inwards do |t|
      t.date :date
      t.string :inward_no

      t.timestamps
    end
  end
end
