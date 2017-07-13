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

ActiveRecord::Schema.define(version: 20170713141705) do

  create_table "cart_items", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "printing_set_id"
    t.integer  "amount"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "cupons", force: :cascade do |t|
    t.string   "code"
    t.integer  "discount"
    t.datetime "end_date"
    t.integer  "printing_hub_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "email_subscriptions", force: :cascade do |t|
    t.string   "email"
    t.string   "key"
    t.boolean  "confirmed"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "unsubscribed"
  end

  create_table "featured_items", force: :cascade do |t|
    t.integer  "printing_set_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "printing_set_id"
    t.integer  "amount"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "order_states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "printing_hub_id"
    t.integer  "order_state_id"
    t.integer  "shipping_type_id"
    t.string   "doge_address"
    t.text     "shipping_address"
    t.integer  "doges"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "zip_code"
    t.text     "tracking_info"
  end

  create_table "printables", force: :cascade do |t|
    t.integer  "printing_set_id"
    t.string   "github_repo"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "printers", force: :cascade do |t|
    t.integer  "printing_hub_id"
    t.string   "name"
    t.string   "ip"
    t.string   "api_user"
    t.string   "api_key"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "printing_hubs", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.decimal  "discount"
  end

  create_table "printing_set_images", force: :cascade do |t|
    t.integer  "printing_set_id"
    t.string   "image"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "printing_sets", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.text     "description"
    t.integer  "printing_hub_id"
    t.decimal  "doges"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "shipping_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "printing_hub_id"
    t.decimal  "doges"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "user_in_printing_hubs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "printing_hub_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
