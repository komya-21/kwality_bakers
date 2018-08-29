class CreateAdditionals < ActiveRecord::Migration[5.1]
  def change
    create_table :additionals do |t|
      t.string :right
      t.string :right_color
      t.string :right_dark
      t.string :right_light
      t.string :left
      t.string :left_color
      t.string :left_dark
      t.string :left_light
      t.string :top
      t.string :top_color
      t.string :top_dark
      t.string :top_light
      t.string :bottom
      t.string :bottom_color
      t.string :bottom_dark
      t.string :bottom_light
      t.references :measurement, foreign_key: true

      t.timestamps
    end
  end
end
