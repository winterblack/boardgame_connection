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

ActiveRecord::Schema.define(version: 2020_02_14_215645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boardgames", force: :cascade do |t|
    t.integer "geek_id"
    t.string "thumbnail"
    t.string "image"
    t.string "name"
    t.integer "year"
    t.integer "min_players"
    t.integer "max_players"
    t.integer "play_time"
    t.float "geek_rating"
    t.integer "geek_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geek_rank"], name: "index_boardgames_on_geek_rank"
    t.index ["geek_rating"], name: "index_boardgames_on_geek_rating"
    t.index ["max_players"], name: "index_boardgames_on_max_players"
    t.index ["min_players"], name: "index_boardgames_on_min_players"
    t.index ["name"], name: "index_boardgames_on_name", unique: true
    t.index ["play_time"], name: "index_boardgames_on_play_time"
    t.index ["year"], name: "index_boardgames_on_year"
  end

end
