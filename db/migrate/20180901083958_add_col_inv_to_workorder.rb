class AddColInvToWorkorder < ActiveRecord::Migration[5.1]
  def change
    add_column :workorders, :invoice_no, :string
  end
end
