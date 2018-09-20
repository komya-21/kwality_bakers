class AddRefToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :employee, foreign_key: true
    add_reference :users, :vendor, foreign_key: true
    add_reference :users, :location, foreign_key: true
  end
end
