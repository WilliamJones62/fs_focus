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

ActiveRecord::Schema.define(version: 20200218161740) do

  create_table "customer_shiptos", force: :cascade do |t|
    t.string "cust_code"
    t.string "shipto_code"
    t.string "bus_name"
    t.string "acct_manager"
    t.boolean "default_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "Badge_"
    t.string "Firstname"
    t.string "Lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "Employee_Name"
  end

  create_table "fs_focus_items", force: :cascade do |t|
    t.string "team"
    t.string "rep"
    t.string "customer"
    t.string "part_code"
    t.string "part_desc"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partmstrs", force: :cascade do |t|
    t.string "part_code"
    t.string "part_desc"
    t.string "part_grp"
    t.string "uom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "focus_items"
    t.string "focus_items_role"
    t.string "focus_items_manager"
    t.string "focus_items_rep1"
    t.string "focus_items_rep2"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
