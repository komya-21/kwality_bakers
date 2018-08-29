class AddColToMeasurement < ActiveRecord::Migration[5.1]
  def change
    add_column :measurements, :back_rate, :float
    add_column :measurements, :bsl_type, :string
  end
end
