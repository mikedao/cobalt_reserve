# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_27_211546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "race"
    t.integer "level"
    t.string "character_class"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "campaign_id", null: false
    t.bigint "user_id", null: false
    t.index ["campaign_id"], name: "index_characters_on_campaign_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "game_session_characters", force: :cascade do |t|
    t.bigint "game_session_id", null: false
    t.bigint "character_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["character_id"], name: "index_game_session_characters_on_character_id"
    t.index ["game_session_id"], name: "index_game_session_characters_on_game_session_id"
  end

  create_table "game_sessions", force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "campaign_id", null: false
    t.index ["campaign_id"], name: "index_game_sessions_on_campaign_id"
  end

  create_table "item_characters", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "character_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["character_id"], name: "index_item_characters_on_character_id"
    t.index ["item_id"], name: "index_item_characters_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "monsters", force: :cascade do |t|
    t.string "name"
    t.string "size"
    t.string "monster_type"
    t.string "alignment"
    t.integer "ac"
    t.integer "hp"
    t.string "speed"
    t.integer "str"
    t.integer "dex"
    t.integer "con"
    t.integer "int"
    t.integer "wis"
    t.integer "cha"
    t.string "saving_throws"
    t.string "skills"
    t.string "weaknesses_resistances_immunities"
    t.string "senses"
    t.string "languages"
    t.float "challenge_rating"
    t.string "additional_abilities"
    t.string "source"
    t.string "author"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "login_uuid"
    t.datetime "login_timestamp"
    t.index ["login_uuid"], name: "index_users_on_login_uuid"
  end

  add_foreign_key "characters", "campaigns"
  add_foreign_key "characters", "users"
  add_foreign_key "game_session_characters", "characters"
  add_foreign_key "game_session_characters", "game_sessions"
  add_foreign_key "game_sessions", "campaigns"
  add_foreign_key "item_characters", "characters"
  add_foreign_key "item_characters", "items"
end
