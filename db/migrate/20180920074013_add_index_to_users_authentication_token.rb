class AddIndexToUsersAuthenticationToken < ActiveRecord::Migration[5.1]
  def change
  	add_index :users, :authentication_token, unique: true
  end
end
