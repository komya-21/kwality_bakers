class CreateVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :address
      t.string :delivery_area
      t.string :gst_no
      t.string :pan_no
      t.string :contact
      t.string :alternate_contact
      t.string :comission

      t.timestamps
    end
  end
end
