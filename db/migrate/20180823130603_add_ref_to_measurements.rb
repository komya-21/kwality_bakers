class AddRefToMeasurements < ActiveRecord::Migration[5.1]
  def change
    add_reference :measurements, :rate, foreign_key: true
  end
end
