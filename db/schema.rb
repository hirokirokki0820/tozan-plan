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

ActiveRecord::Schema[7.0].define(version: 2022_09_10_115200) do
  create_table "companions", force: :cascade do |t|
    t.string "role"
    t.string "full_name"
    t.string "gender"
    t.integer "age"
    t.date "birthday"
    t.string "address"
    t.string "phone_number"
    t.string "emergency_contact"
    t.string "emergency_number"
    t.string "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_companions_on_plan_id"
  end

  create_table "plans", id: :string, force: :cascade do |t|
    t.string "destination"
    t.string "submit_to"
    t.date "start_day"
    t.date "last_day"
    t.string "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "full_name"
    t.string "gender"
    t.date "birthday"
    t.integer "age"
    t.string "address"
    t.string "phone_number"
    t.string "emergency_contact"
    t.string "emergency_number"
    t.string "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
  end

  create_table "users", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated"
    t.datetime "activated_at"
    t.datetime "activation_sent_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "full_name"
    t.date "birthday"
    t.integer "age"
    t.string "gender"
    t.string "address"
    t.string "phone_number"
    t.string "emergency_contact"
    t.string "emergency_number"
  end

  add_foreign_key "companions", "plans"
  add_foreign_key "plans", "users"
  add_foreign_key "profiles", "users"
end
