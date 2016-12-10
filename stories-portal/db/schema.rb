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

ActiveRecord::Schema.define(version: 20161204174511) do

  create_table "accesses", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "type_address"
    t.string   "street"
    t.string   "number"
    t.string   "postal_code"
    t.string   "neighborhood"
    t.string   "city"
    t.string   "country"
    t.string   "complement"
    t.string   "reference"
    t.integer  "customer_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "main_address", default: false
    t.string   "alias"
    t.integer  "state_id"
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
    t.index ["state_id"], name: "index_addresses_on_state_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "categories_has_products", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_categories_has_products_on_category_id"
    t.index ["product_id"], name: "index_categories_has_products_on_product_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "lastname"
    t.string   "username"
    t.string   "email",                  default: "", null: false
    t.string   "cpf"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "access_id"
    t.boolean  "active"
    t.index ["access_id"], name: "index_customers_on_access_id"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "galleries", force: :cascade do |t|
    t.text     "description"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.boolean  "active"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["attachable_type", "attachable_id"], name: "index_galleries_on_attachable_type_and_attachable_id"
  end

  create_table "newsletters", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.decimal  "unit_price",  precision: 12, scale: 2
    t.integer  "quantity",                             default: 0
    t.decimal  "total_price", precision: 12, scale: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "payment_id"
    t.integer  "customer_id"
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
    t.integer  "order_status_id"
    t.decimal  "subtotal",                  precision: 12, scale: 3, default: "0.0"
    t.decimal  "tax",                       precision: 12, scale: 3
    t.decimal  "shipping",                  precision: 12, scale: 3
    t.decimal  "total",                     precision: 12, scale: 3, default: "0.0"
    t.integer  "order_number",    limit: 8
    t.integer  "address_id"
    t.string   "shipping_name"
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["order_status_id"], name: "index_orders_on_order_status_id"
    t.index ["payment_id"], name: "index_orders_on_payment_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "description_short"
    t.string   "sku",                                                        null: false
    t.boolean  "featured",                                   default: false
    t.boolean  "active",                                     default: false
    t.decimal  "cost_price",        precision: 12, scale: 2, default: "0.0"
    t.decimal  "sale_price",        precision: 12, scale: 2, default: "0.0", null: false
    t.decimal  "promotional_price", precision: 12, scale: 2, default: "0.0"
    t.decimal  "weight",            precision: 12, scale: 2, default: "0.0", null: false
    t.decimal  "height",            precision: 12, scale: 2, default: "0.0", null: false
    t.decimal  "width",             precision: 12, scale: 2, default: "0.0", null: false
    t.decimal  "depth",             precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.integer  "balance"
    t.string   "slug"
    t.integer  "qty_min_in_cart",                            default: 1
    t.integer  "qty_max_in_cart"
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
