class AddColToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :authentication_token, :text
    add_column :users, :authentication_token_created_at, :datetime
  end
end
