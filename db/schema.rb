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

ActiveRecord::Schema.define(version: 20140315133842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "balances", force: true do |t|
    t.float    "exchanged"
    t.float    "unexchanged"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "balances", ["address_id"], name: "index_balances_on_address_id", using: :btree

  create_table "hash_rates", force: true do |t|
    t.float    "hash_rate"
    t.float    "reject_rate"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hash_rates", ["address_id"], name: "index_hash_rates_on_address_id", using: :btree

  create_table "payouts", force: true do |t|
    t.datetime "timestamp"
    t.float    "value"
    t.string   "tx"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payouts", ["address_id"], name: "index_payouts_on_address_id", using: :btree

end
