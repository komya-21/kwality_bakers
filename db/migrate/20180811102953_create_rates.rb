class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.string :product
      t.string :ptype
      t.float :price

      t.timestamps
    end
  end
end
