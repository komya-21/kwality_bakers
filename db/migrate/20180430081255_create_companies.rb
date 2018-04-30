class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :fssai_lic_no
      t.string :contact_no
      t.string :email
      t.string :gst_no

      t.timestamps
    end
  end
end
