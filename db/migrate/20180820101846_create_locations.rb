class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.text :address
      t.string :code
      t.string :city
      t.string :contact

      t.timestamps
    end
  end
end
