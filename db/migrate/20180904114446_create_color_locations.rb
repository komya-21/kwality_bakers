class CreateColorLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :color_locations do |t|
      t.references :color, foreign_key: true
      t.string :located

      t.timestamps
    end
  end
end
