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

ActiveRecord::Schema.define(version: 20180602124514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aggregated_market_prices", force: :cascade do |t|
    t.decimal "open"
    t.decimal "close"
    t.decimal "high"
    t.decimal "volume"
    t.datetime "price_date"
    t.bigint "market_id"
    t.integer "interval_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_id"], name: "index_aggregated_market_prices_on_market_id"
  end

  create_table "market_prices", force: :cascade do |t|
    t.decimal "open"
    t.decimal "close"
    t.decimal "high"
    t.decimal "volume"
    t.datetime "price_date"
    t.bigint "market_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_id"], name: "index_market_prices_on_market_id"
  end

  create_table "markets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
