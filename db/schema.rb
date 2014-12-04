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

ActiveRecord::Schema.define(version: 20141204203815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "phone_num"
    t.string   "alt_phone_num"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers_products", id: false, force: true do |t|
    t.integer "customer_id"
    t.integer "product_id"
  end

  create_table "orders", force: true do |t|
    t.string   "placed_by"
    t.date     "placed_date"
    t.date     "follow_up_date"
    t.integer  "customer_id"
    t.integer  "product_id"
    t.decimal  "items_total",       precision: 20, scale: 2, default: 0.0
    t.decimal  "tax",               precision: 20, scale: 2, default: 0.0
    t.decimal  "total_with_tax",    precision: 20, scale: 2, default: 0.0
    t.decimal  "delivery",          precision: 20, scale: 2, default: 0.0
    t.decimal  "assembly",          precision: 20, scale: 2, default: 0.0
    t.decimal  "grand_total",       precision: 20, scale: 2, default: 0.0
    t.decimal  "deposit",           precision: 20, scale: 2, default: 0.0
    t.decimal  "balance_due",       precision: 20, scale: 2, default: 0.0
    t.text     "notes"
    t.string   "purchased_by"
    t.text     "gift_note"
    t.boolean  "complete"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "store_location"
    t.string   "updated_by"
    t.decimal  "delivery_with_tax", precision: 20, scale: 2, default: 0.0
  end

  create_table "orders_products", id: false, force: true do |t|
    t.integer "order_id"
    t.integer "product_id"
  end

  create_table "products", force: true do |t|
    t.string   "company"
    t.string   "model_type"
    t.string   "description"
    t.decimal  "price",              precision: 20, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "discount",           precision: 20, scale: 2
    t.boolean  "picked_up",                                   default: false
    t.date     "pick_up_date"
    t.string   "pickup_or_delivery",                          default: "Pickup"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
