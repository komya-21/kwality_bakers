class AddColumnToRates < ActiveRecord::Migration[5.1]
  def change
    add_column :rates, :ctype, :string
  end
end
