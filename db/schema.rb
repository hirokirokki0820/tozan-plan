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

ActiveRecord::Schema[7.0].define(version: 2022_09_17_140729) do
  create_table "address_books", force: :cascade do |t|
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
    t.index ["user_id"], name: "index_address_books_on_user_id"
  end

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

  create_table "plan_clubs", force: :cascade do |t|
    t.string "belongs_to"
    t.string "group_name"
    t.string "representative_name"
    t.string "representative_address"
    t.string "representative_number"
    t.string "emergency_contact"
    t.string "address"
    t.string "phone_number"
    t.string "rescue_system"
    t.string "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_plan_clubs_on_plan_id"
  end

  create_table "plan_equipments", force: :cascade do |t|
    t.string "food"
    t.string "emergency_food"
    t.string "camp_equipment"
    t.string "climbing_equipment"
    t.string "wireless"
    t.string "others"
    t.string "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_plan_equipments_on_plan_id"
  end

  create_table "plan_escapes", force: :cascade do |t|
    t.text "escape_route"
    t.string "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_plan_escapes_on_plan_id"
  end

  create_table "plan_schedules", force: :cascade do |t|
    t.date "date"
    t.text "schedule"
    t.string "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_plan_schedules_on_plan_id"
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

  create_table "schedule_spots", force: :cascade do |t|
    t.string "spot"
    t.time "time"
    t.integer "plan_schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_schedule_id"], name: "index_schedule_spots_on_plan_schedule_id"
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
  end

  add_foreign_key "address_books", "users"
  add_foreign_key "companions", "plans"
  add_foreign_key "plan_clubs", "plans"
  add_foreign_key "plan_equipments", "plans"
  add_foreign_key "plan_escapes", "plans"
  add_foreign_key "plan_schedules", "plans"
  add_foreign_key "plans", "users"
  add_foreign_key "schedule_spots", "plan_schedules"
end
