class AddRefToInwards < ActiveRecord::Migration[5.1]
  def change
    add_reference :inwards, :supplier, foreign_key: true
  end
end
