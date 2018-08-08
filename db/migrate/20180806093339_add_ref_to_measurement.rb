class AddRefToMeasurement < ActiveRecord::Migration[5.1]
  def change
    add_reference :measurements, :fproduct, foreign_key: true
  end
end
