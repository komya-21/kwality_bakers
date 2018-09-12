class AddColAToMeasurements < ActiveRecord::Migration[5.1]
  def change
    add_column :measurements, :right, :string
    add_column :measurements, :right_dark, :string
    add_column :measurements, :right_light, :string
    add_column :measurements, :left, :string
    add_column :measurements, :left_dark, :string
    add_column :measurements, :left_light, :string
    add_column :measurements, :top, :string
    add_column :measurements, :top_dark, :string
    add_column :measurements, :top_light, :string
    add_column :measurements, :bottom, :string
    add_column :measurements, :bottom_dark, :string
    add_column :measurements, :bottom_light, :string
  end
end
