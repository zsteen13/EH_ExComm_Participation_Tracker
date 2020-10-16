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

ActiveRecord::Schema.define(version: 2020_10_16_193842) do

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.string "_type"
    t.string "date"
    t.decimal "point_value"
    t.string "description"
    t.decimal "num_rsvp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "committees", force: :cascade do |t|
    t.integer "committee_id"
    t.string "committee"
    t.integer "point_threshold"
    t.string "head_first_name"
    t.string "head_last_name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "privledges", force: :cascade do |t|
    t.integer "privledge_id"
    t.string "privledge"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subcommittees", force: :cascade do |t|
    t.integer "subcommittee_id"
    t.string "subcommittee"
    t.integer "point_threshold"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_keys", id: false, force: :cascade do |t|
    t.string "key", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_user_keys_on_user_id"
  end

  create_table "user_to_activities", force: :cascade do |t|
    t.string "uin"
    t.integer "activity_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uin", "activity_id"], name: "index_user_to_activities_on_uin_and_activity_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "uin"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "committee"
    t.string "subcommittee"
    t.integer "total_points"
    t.integer "meeting_points"
    t.integer "event_points"
    t.integer "misc_points"
    t.boolean "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "privledge_id"
    t.integer "class_year"
    t.integer "point_threshold"
  end

end
