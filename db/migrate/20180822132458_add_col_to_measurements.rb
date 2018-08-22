class AddColToMeasurements < ActiveRecord::Migration[5.1]
  def change
    add_column :measurements, :glass_shutter, :string
    add_column :measurements, :handle, :string
    add_column :measurements, :handle_groove, :string
    add_column :measurements, :handle_fitting, :string
  end
end
