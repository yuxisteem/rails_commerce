# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140907141915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "city"
    t.string   "street"
    t.string   "phone"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["order_id"], name: "index_addresses_on_order_id", using: :btree

  create_table "brands", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight"
  end

  create_table "cart_items", force: true do |t|
    t.integer  "quantity",   default: 1
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id", using: :btree

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "attribute_filter_enabled", default: true
    t.boolean  "brand_filter_enabled",     default: true
    t.integer  "weight"
    t.boolean  "active"
  end

  create_table "images", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "images", ["imageable_id", "imageable_type"], name: "index_images_on_imageable_id_and_imageable_type", using: :btree

  create_table "invoices", force: true do |t|
    t.integer  "order_id"
    t.integer  "payment_method"
    t.decimal  "amount"
    t.string   "invoice_type"
    t.string   "aasm_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["aasm_state"], name: "index_invoices_on_aasm_state", using: :btree
  add_index "invoices", ["order_id"], name: "index_invoices_on_order_id", using: :btree

  create_table "order_histories", force: true do |t|
    t.integer  "order_id"
    t.string   "attribute_name"
    t.string   "from_name"
    t.string   "to_name"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "order_histories", ["order_id"], name: "index_order_histories_on_order_id", using: :btree

  create_table "order_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.string   "code"
    t.string   "aasm_state"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["aasm_state"], name: "index_orders_on_aasm_state", using: :btree
  add_index "orders", ["code"], name: "index_orders_on_code", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.string   "seo_url"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight"
  end

  create_table "payment_methods", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_attribute_names", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.boolean  "filterable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight"
  end

  add_index "product_attribute_names", ["category_id"], name: "index_product_attribute_names_on_category_id", using: :btree
  add_index "product_attribute_names", ["name"], name: "index_product_attribute_names_on_name", using: :btree

  create_table "product_attribute_values", force: true do |t|
    t.string   "value"
    t.integer  "product_id"
    t.integer  "product_attribute_name_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_attribute_values", ["product_attribute_name_id"], name: "index_product_attribute_values_on_product_attribute_name_id", using: :btree
  add_index "product_attribute_values", ["product_id"], name: "index_product_attribute_values_on_product_id", using: :btree
  add_index "product_attribute_values", ["value"], name: "index_product_attribute_values_on_value", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.boolean  "active"
    t.integer  "category_id"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "track_inventory", default: false
    t.integer  "quantity",        default: 0
  end

  add_index "products", ["active"], name: "index_products_on_active", using: :btree
  add_index "products", ["brand_id"], name: "index_products_on_brand_id", using: :btree
  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "shipments", force: true do |t|
    t.integer  "order_id"
    t.integer  "shipping_method_id"
    t.integer  "address_id"
    t.string   "tracking"
    t.string   "aasm_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shipments", ["aasm_state"], name: "index_shipments_on_aasm_state", using: :btree
  add_index "shipments", ["address_id"], name: "index_shipments_on_address_id", using: :btree
  add_index "shipments", ["order_id"], name: "index_shipments_on_order_id", using: :btree
  add_index "shipments", ["shipping_method_id"], name: "index_shipments_on_shipping_method_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin"
    t.boolean  "receive_sms",            default: true
    t.boolean  "receive_email",          default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
