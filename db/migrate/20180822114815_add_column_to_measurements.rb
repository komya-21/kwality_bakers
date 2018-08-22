class AddColumnToMeasurements < ActiveRecord::Migration[5.1]
  def change
    add_column :measurements, :rate, :float
  end
end
