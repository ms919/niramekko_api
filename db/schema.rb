# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_03_075123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_results", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "mode", null: false
    t.integer "score", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "title", null: false
    t.index ["title"], name: "index_game_results_on_title"
    t.index ["user_id"], name: "index_game_results_on_user_id"
  end

  create_table "laughed_videos", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "video_id", null: false
    t.integer "score_diff", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_laughed_videos_on_user_id"
    t.index ["video_id"], name: "index_laughed_videos_on_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid", null: false
    t.string "provider", null: false
    t.string "name"
    t.string "image_url"
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.bigint "user_id"
    t.string "video_user", null: false
    t.string "data_video_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

  add_foreign_key "game_results", "users"
  add_foreign_key "laughed_videos", "users"
  add_foreign_key "laughed_videos", "videos"
  add_foreign_key "videos", "users"
end
