class AddColsToMeasurements < ActiveRecord::Migration[5.1]
  def change
    add_column :measurements, :sqft, :float
    add_column :measurements, :sqft_back, :float
    add_column :measurements, :color_sqft, :float
  end
end
