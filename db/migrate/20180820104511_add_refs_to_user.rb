class AddRefsToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :location, foreign_key: true
  end
end
