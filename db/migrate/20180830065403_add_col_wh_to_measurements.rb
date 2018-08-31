class AddColWhToMeasurements < ActiveRecord::Migration[5.1]
  def change
    add_column :measurements, :wh, :string
  end
end
