# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180920110504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additionals", force: :cascade do |t|
    t.string "right"
    t.string "right_color"
    t.string "right_dark"
    t.string "right_light"
    t.string "left"
    t.string "left_color"
    t.string "left_dark"
    t.string "left_light"
    t.string "top"
    t.string "top_color"
    t.string "top_dark"
    t.string "top_light"
    t.string "bottom"
    t.string "bottom_color"
    t.string "bottom_dark"
    t.string "bottom_light"
    t.bigint "measurement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["measurement_id"], name: "index_additionals_on_measurement_id"
  end

  create_table "color_locations", force: :cascade do |t|
    t.bigint "color_id"
    t.string "located"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["color_id"], name: "index_color_locations_on_color_id"
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "price"
    t.string "light"
    t.string "dark"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "contact_no"
    t.string "email"
    t.string "gst_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "current_inventories", force: :cascade do |t|
    t.string "current_quantity"
    t.bigint "inward_product_id"
    t.bigint "delivery_inward_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.index ["delivery_inward_id"], name: "index_current_inventories_on_delivery_inward_id"
    t.index ["inward_product_id"], name: "index_current_inventories_on_inward_product_id"
    t.index ["product_id"], name: "index_current_inventories_on_product_id"
  end

  create_table "deductions", force: :cascade do |t|
    t.bigint "employee_payroll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_payroll_id"], name: "index_deductions_on_employee_payroll_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "invoice_no"
    t.date "date"
    t.bigint "vendor_id"
    t.string "bill_checked_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "add_price"
    t.string "remaining_price"
    t.string "total_to_pay"
    t.boolean "payment_status", default: false
    t.string "comission"
    t.index ["vendor_id"], name: "index_deliveries_on_vendor_id"
  end

  create_table "delivery_inwards", force: :cascade do |t|
    t.bigint "delivery_id"
    t.bigint "inward_product_id"
    t.string "rate"
    t.string "quantity"
    t.string "rem_quantity"
    t.string "qty"
    t.string "total_amt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.bigint "vendor_id"
    t.string "price"
    t.integer "gst"
    t.string "total"
    t.index ["delivery_id"], name: "index_delivery_inwards_on_delivery_id"
    t.index ["inward_product_id"], name: "index_delivery_inwards_on_inward_product_id"
    t.index ["product_id"], name: "index_delivery_inwards_on_product_id"
    t.index ["vendor_id"], name: "index_delivery_inwards_on_vendor_id"
  end

  create_table "earnings", force: :cascade do |t|
    t.bigint "employee_payroll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_payroll_id"], name: "index_earnings_on_employee_payroll_id"
  end

  create_table "emp_works", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "in_time"
    t.string "out_time"
    t.string "work_hours"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_emp_works_on_employee_id"
  end

  create_table "employee_payrolls", force: :cascade do |t|
    t.string "category_name"
    t.string "percentage"
    t.boolean "is_deduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "contact_no"
    t.string "email"
    t.string "address"
    t.string "employee_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "employee_type"
    t.bigint "location_id"
    t.index ["location_id"], name: "index_employees_on_location_id"
  end

  create_table "employees_workorders", force: :cascade do |t|
    t.string "starttime"
    t.string "endtime"
    t.bigint "employee_id"
    t.bigint "workorder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["employee_id"], name: "index_employees_workorders_on_employee_id"
    t.index ["workorder_id"], name: "index_employees_workorders_on_workorder_id"
  end

  create_table "fproducts", force: :cascade do |t|
    t.string "product"
    t.bigint "workorder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workorder_id"], name: "index_fproducts_on_workorder_id"
  end

  create_table "furnitures", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inward_products", force: :cascade do |t|
    t.string "quantity"
    t.bigint "product_id"
    t.bigint "inward_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "updated_quantity"
    t.integer "total_quantity"
    t.string "after_inward"
    t.string "after_delivery_string"
    t.float "width"
    t.float "height"
    t.string "category"
    t.bigint "color_id"
    t.string "unit"
    t.float "price"
    t.index ["color_id"], name: "index_inward_products_on_color_id"
    t.index ["inward_id"], name: "index_inward_products_on_inward_id"
    t.index ["product_id"], name: "index_inward_products_on_product_id"
  end

  create_table "inwards", force: :cascade do |t|
    t.date "date"
    t.string "inward_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "supplier_id"
    t.float "total_to_pay"
    t.integer "add_price"
    t.integer "rem_price"
    t.index ["supplier_id"], name: "index_inwards_on_supplier_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "code"
    t.string "city"
    t.string "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  create_table "measurements", force: :cascade do |t|
    t.string "ftype"
    t.float "width"
    t.float "depth"
    t.float "height"
    t.bigint "color_id"
    t.string "side"
    t.float "skirting"
    t.integer "quantity"
    t.integer "horizontal"
    t.integer "vertical"
    t.integer "center"
    t.string "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "fproduct_id"
    t.float "rate"
    t.string "glass_shutter"
    t.string "handle"
    t.string "handle_groove"
    t.string "handle_fitting"
    t.bigint "rate_id"
    t.float "back_rate"
    t.string "bsl_type"
    t.string "wh"
    t.string "right"
    t.string "right_dark"
    t.string "right_light"
    t.string "left"
    t.string "left_dark"
    t.string "left_light"
    t.string "top"
    t.string "top_dark"
    t.string "top_light"
    t.string "bottom"
    t.string "bottom_dark"
    t.string "bottom_light"
    t.index ["color_id"], name: "index_measurements_on_color_id"
    t.index ["fproduct_id"], name: "index_measurements_on_fproduct_id"
    t.index ["rate_id"], name: "index_measurements_on_rate_id"
  end

  create_table "payslips", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "earning_id"
    t.bigint "deduction_id"
    t.date "date"
    t.string "basic_salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gross_salary"
    t.string "net_salary"
    t.string "month_year"
    t.index ["deduction_id"], name: "index_payslips_on_deduction_id"
    t.index ["earning_id"], name: "index_payslips_on_earning_id"
    t.index ["employee_id"], name: "index_payslips_on_employee_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "delivery_quantity"
    t.string "unit"
  end

  create_table "rates", force: :cascade do |t|
    t.string "product"
    t.string "ptype"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ctype"
  end

  create_table "returns", force: :cascade do |t|
    t.string "date_of_return"
    t.string "invoice_number"
    t.bigint "vendor_id"
    t.bigint "inward_product_id"
    t.string "return_quantity"
    t.string "purpose"
    t.string "receipt_no"
    t.string "return_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.index ["inward_product_id"], name: "index_returns_on_inward_product_id"
    t.index ["product_id"], name: "index_returns_on_product_id"
    t.index ["vendor_id"], name: "index_returns_on_vendor_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "contact"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transaction_details", force: :cascade do |t|
    t.date "date"
    t.bigint "inward_id"
    t.boolean "payment_status"
    t.string "payment_mode"
    t.string "bank_name"
    t.string "cheque_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inward_id"], name: "index_transaction_details_on_inward_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.bigint "vendor_id"
    t.bigint "location_id"
    t.text "authentication_token"
    t.datetime "authentication_token_created_at"
    t.string "role"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["employee_id"], name: "index_users_on_employee_id"
    t.index ["location_id"], name: "index_users_on_location_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["vendor_id"], name: "index_users_on_vendor_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "delivery_area"
    t.string "gst_no"
    t.string "pan_no"
    t.string "contact"
    t.string "alternate_contact"
    t.string "comission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vendor_type"
    t.string "email"
    t.string "password"
    t.bigint "location_id"
    t.index ["location_id"], name: "index_vendors_on_location_id"
  end

  create_table "work_orders", force: :cascade do |t|
    t.float "width"
    t.float "depth"
    t.float "height"
    t.bigint "quantity"
    t.bigint "color_id"
    t.string "side"
    t.float "skirting"
    t.integer "horizontal"
    t.integer "vertical"
    t.integer "center"
    t.string "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "furniture_product"
    t.string "furniture_type"
    t.index ["color_id"], name: "index_work_orders_on_color_id"
  end

  create_table "workorders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name1"
    t.string "name2"
    t.string "name3"
    t.string "name4"
    t.string "name5"
    t.string "photo1_file_name"
    t.string "photo1_content_type"
    t.integer "photo1_file_size"
    t.datetime "photo1_updated_at"
    t.string "photo2_file_name"
    t.string "photo2_content_type"
    t.integer "photo2_file_size"
    t.datetime "photo2_updated_at"
    t.string "photo3_file_name"
    t.string "photo3_content_type"
    t.integer "photo3_file_size"
    t.datetime "photo3_updated_at"
    t.string "photo4_file_name"
    t.string "photo4_content_type"
    t.integer "photo4_file_size"
    t.datetime "photo4_updated_at"
    t.string "photo5_file_name"
    t.string "photo5_content_type"
    t.integer "photo5_file_size"
    t.datetime "photo5_updated_at"
    t.string "order_no"
    t.bigint "vendor_id"
    t.date "date"
    t.boolean "approve"
    t.boolean "remove_photo1"
    t.boolean "remove_photo2"
    t.boolean "remove_photo3"
    t.boolean "remove_photo4"
    t.boolean "remove_photo5"
    t.bigint "employee_id"
    t.bigint "location_id"
    t.bigint "color_id"
    t.string "invoice_no"
    t.string "total_to_pay"
    t.string "add_price"
    t.string "rem_price"
    t.boolean "payment_status"
    t.string "dark_color"
    t.string "light_color"
    t.boolean "delivered"
    t.index ["color_id"], name: "index_workorders_on_color_id"
    t.index ["employee_id"], name: "index_workorders_on_employee_id"
    t.index ["location_id"], name: "index_workorders_on_location_id"
    t.index ["vendor_id"], name: "index_workorders_on_vendor_id"
  end

  add_foreign_key "additionals", "measurements"
  add_foreign_key "color_locations", "colors"
  add_foreign_key "current_inventories", "delivery_inwards"
  add_foreign_key "current_inventories", "inward_products"
  add_foreign_key "current_inventories", "products"
  add_foreign_key "deductions", "employee_payrolls"
  add_foreign_key "deliveries", "vendors"
  add_foreign_key "delivery_inwards", "deliveries"
  add_foreign_key "delivery_inwards", "inward_products"
  add_foreign_key "delivery_inwards", "products"
  add_foreign_key "delivery_inwards", "vendors"
  add_foreign_key "earnings", "employee_payrolls"
  add_foreign_key "emp_works", "employees"
  add_foreign_key "employees", "locations"
  add_foreign_key "employees_workorders", "employees"
  add_foreign_key "employees_workorders", "workorders"
  add_foreign_key "fproducts", "workorders"
  add_foreign_key "inward_products", "colors"
  add_foreign_key "inward_products", "inwards"
  add_foreign_key "inward_products", "products"
  add_foreign_key "inwards", "suppliers"
  add_foreign_key "measurements", "colors"
  add_foreign_key "measurements", "fproducts"
  add_foreign_key "measurements", "rates"
  add_foreign_key "payslips", "deductions"
  add_foreign_key "payslips", "earnings"
  add_foreign_key "payslips", "employees"
  add_foreign_key "returns", "inward_products"
  add_foreign_key "returns", "products"
  add_foreign_key "returns", "vendors"
  add_foreign_key "transaction_details", "inwards"
  add_foreign_key "users", "employees"
  add_foreign_key "users", "locations"
  add_foreign_key "users", "vendors"
  add_foreign_key "vendors", "locations"
  add_foreign_key "work_orders", "colors"
  add_foreign_key "workorders", "colors"
  add_foreign_key "workorders", "employees"
  add_foreign_key "workorders", "locations"
  add_foreign_key "workorders", "vendors"
end
