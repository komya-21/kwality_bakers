class AddRefToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_reference :employees, :location, foreign_key: true
  end
end
