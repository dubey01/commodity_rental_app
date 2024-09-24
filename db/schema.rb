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

ActiveRecord::Schema.define(version: 2024_09_24_063324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commodities", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.string "make"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["category_id"], name: "index_commodities_on_category_id"
  end

  create_table "leases", force: :cascade do |t|
    t.bigint "listing_id"
    t.bigint "renter_bid_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_leases_on_listing_id"
    t.index ["renter_bid_id"], name: "index_leases_on_renter_bid_id"
  end

  create_table "listings", force: :cascade do |t|
    t.bigint "lender_id"
    t.bigint "commodity_id"
    t.float "price_per_month", null: false
    t.integer "strategy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commodity_id"], name: "index_listings_on_commodity_id"
    t.index ["lender_id"], name: "index_listings_on_lender_id"
  end

  create_table "renter_bids", force: :cascade do |t|
    t.bigint "renter_id"
    t.bigint "listing_id"
    t.float "bid_price", null: false
    t.integer "lease_period_in_month", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_renter_bids_on_listing_id"
    t.index ["renter_id"], name: "index_renter_bids_on_renter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "email"
    t.string "phone_no"
    t.integer "type", limit: 2
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "listings", "users", column: "lender_id"
  add_foreign_key "renter_bids", "users", column: "renter_id"
end
