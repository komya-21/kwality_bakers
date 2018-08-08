class CreateMeasurements < ActiveRecord::Migration[5.1]
  def change
    create_table :measurements do |t|
      t.string :ftype
      t.float :width
      t.float :depth
      t.float :height
      t.references :color, foreign_key: true
      t.string :side
      t.float :skirting
      t.integer :quantity
      t.integer :horizontal
      t.integer :vertical
      t.integer :center
      t.string :total

      t.timestamps
    end
  end
end
