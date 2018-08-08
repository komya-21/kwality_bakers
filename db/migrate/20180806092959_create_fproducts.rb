class CreateFproducts < ActiveRecord::Migration[5.1]
  def change
    create_table :fproducts do |t|
      t.string :product
      t.references :workorder, foreign_key: true
      

      t.timestamps
    end
  end
end
