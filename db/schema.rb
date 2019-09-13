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

ActiveRecord::Schema.define(version: 2019_09_13_140856) do

  create_table "academies", force: :cascade do |t|
    t.string "name", null: false
    t.string "city", null: false
    t.integer "academy_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "academy_opinions", force: :cascade do |t|
    t.text "body", null: false
    t.boolean "is_positive", null: false
    t.integer "user_id"
    t.integer "academy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id", "user_id"], name: "one_academy_opinion", unique: true
    t.index ["academy_id"], name: "index_academy_opinions_on_academy_id"
    t.index ["user_id"], name: "index_academy_opinions_on_user_id"
  end

  create_table "field_details", force: :cascade do |t|
    t.integer "academy_id"
    t.integer "field_of_study_id"
    t.integer "students_limit"
    t.string "recrutation_formula"
    t.integer "minimal_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "interested_count", default: 0
    t.index ["academy_id", "field_of_study_id"], name: "index_field_details_on_academy_id_and_field_of_study_id", unique: true
    t.index ["academy_id"], name: "index_field_details_on_academy_id"
    t.index ["field_of_study_id"], name: "index_field_details_on_field_of_study_id"
  end

  create_table "field_of_studies", force: :cascade do |t|
    t.string "name"
    t.integer "field_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "field_opinions", force: :cascade do |t|
    t.text "body", null: false
    t.boolean "is_positive", null: false
    t.integer "user_id"
    t.integer "field_of_study_id"
    t.integer "academy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id", "field_of_study_id", "user_id"], name: "one_field_opinion", unique: true
    t.index ["academy_id"], name: "index_field_opinions_on_academy_id"
    t.index ["field_of_study_id"], name: "index_field_opinions_on_field_of_study_id"
    t.index ["user_id"], name: "index_field_opinions_on_user_id"
  end

  create_table "high_schools", force: :cascade do |t|
    t.string "name", null: false
    t.string "city", null: false
    t.integer "school_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interesteds", force: :cascade do |t|
    t.integer "field_detail_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_detail_id", "user_id"], name: "index_interesteds_on_field_detail_id_and_user_id", unique: true
    t.index ["field_detail_id"], name: "index_interesteds_on_field_detail_id"
    t.index ["user_id"], name: "index_interesteds_on_user_id"
  end

  create_table "matura_results", force: :cascade do |t|
    t.integer "user_id"
    t.integer "level"
    t.integer "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "matura_subject_id"
    t.index ["matura_subject_id"], name: "index_matura_results_on_matura_subject_id"
    t.index ["user_id"], name: "index_matura_results_on_user_id"
  end

  create_table "matura_subjects", force: :cascade do |t|
    t.string "name"
    t.integer "subject_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "study_interests", force: :cascade do |t|
    t.integer "field_of_study_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_of_study_id"], name: "index_study_interests_on_field_of_study_id"
    t.index ["user_id", "field_of_study_id"], name: "index_study_interests_on_user_id_and_field_of_study_id", unique: true
    t.index ["user_id"], name: "index_study_interests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "password_salt"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.date "date_of_birth"
    t.integer "gender"
    t.string "city"
    t.integer "account_type", null: false
    t.date "date_of_matura"
    t.integer "high_school_id"
    t.integer "academy_id"
    t.integer "field_of_study_id"
    t.integer "interested_count", default: 0
    t.index ["academy_id"], name: "index_users_on_academy_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["field_of_study_id"], name: "index_users_on_field_of_study_id"
    t.index ["high_school_id"], name: "index_users_on_high_school_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
