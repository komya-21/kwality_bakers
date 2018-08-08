class AddRefToFproduct < ActiveRecord::Migration[5.1]
  def change
    add_reference :fproducts, :product, foreign_key: true
  end
end
