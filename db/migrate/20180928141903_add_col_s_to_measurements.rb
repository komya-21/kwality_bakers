class AddColSToMeasurements < ActiveRecord::Migration[5.1]
  def change
    add_column :measurements, :shutter_shade, :string
  end
end
