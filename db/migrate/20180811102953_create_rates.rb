class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.references :product, foreign_key: true
      t.string :ptype
      t.float :price

      t.timestamps
    end
  end
end
