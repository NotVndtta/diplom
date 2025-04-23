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

ActiveRecord::Schema[8.0].define(version: 2025_04_23_202855) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "experiences", force: :cascade do |t|
    t.date "start_date_at"
    t.date "end_date_at"
    t.text "description"
    t.string "company"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_experiences_on_user_id"
  end

  create_table "foreman_descriptions", force: :cascade do |t|
    t.string "farm_name"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_foreman_descriptions_on_user_id"
  end

  create_table "job_applications", force: :cascade do |t|
    t.bigint "job_card_id", null: false
    t.bigint "user_id", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_card_id", "user_id"], name: "index_job_applications_on_job_card_id_and_user_id", unique: true
    t.index ["job_card_id"], name: "index_job_applications_on_job_card_id"
    t.index ["user_id"], name: "index_job_applications_on_user_id"
  end

  create_table "job_cards", force: :cascade do |t|
    t.string "farm_name"
    t.integer "remuneration"
    t.integer "work_amount"
    t.text "description"
    t.date "date_at"
    t.string "location"
    t.string "status"
    t.integer "count_users"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_job_cards_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.text "comment", null: false
    t.integer "grade", null: false
    t.string "rateable_type", null: false
    t.bigint "rateable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rateable_type", "rateable_id"], name: "index_ratings_on_rateable"
    t.index ["rateable_type", "rateable_id"], name: "index_ratings_on_rateable_type_and_rateable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "about"
    t.string "phone"
    t.integer "birth_year", null: false
    t.string "city", null: false
    t.string "role", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vineyard_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "experiences", "users"
  add_foreign_key "foreman_descriptions", "users"
  add_foreign_key "job_applications", "job_cards"
  add_foreign_key "job_applications", "users"
  add_foreign_key "job_cards", "users"
end
