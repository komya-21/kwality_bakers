class AddColGToWorkorders < ActiveRecord::Migration[5.1]
  def change
    add_column :workorders, :g_section, :string
    add_column :workorders, :g_section_with_end_cap, :string
  end
end
