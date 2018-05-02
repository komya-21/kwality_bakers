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

ActiveRecord::Schema.define(version: 20180502105356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "fssai_lic_no"
    t.string "contact_no"
    t.string "email"
    t.string "gst_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["delivery_id"], name: "index_delivery_inwards_on_delivery_id"
    t.index ["inward_product_id"], name: "index_delivery_inwards_on_inward_product_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "contact_no"
    t.string "email"
    t.string "address"
    t.string "employee_no"
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
    t.index ["inward_id"], name: "index_inward_products_on_inward_id"
    t.index ["product_id"], name: "index_inward_products_on_product_id"
  end

  create_table "inwards", force: :cascade do |t|
    t.date "date"
    t.string "inward_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["inward_product_id"], name: "index_returns_on_inward_product_id"
    t.index ["vendor_id"], name: "index_returns_on_vendor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "role"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
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
  end

  add_foreign_key "deliveries", "vendors"
  add_foreign_key "delivery_inwards", "deliveries"
  add_foreign_key "delivery_inwards", "inward_products"
  add_foreign_key "inward_products", "inwards"
  add_foreign_key "inward_products", "products"
  add_foreign_key "returns", "inward_products"
  add_foreign_key "returns", "vendors"
end
