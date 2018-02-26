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

ActiveRecord::Schema.define(version: 20180219141052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text "answer"
    t.integer "next_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers_to_questions", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "next_question_id"
    t.index ["answer_id"], name: "index_answers_to_questions_on_answer_id"
    t.index ["question_id"], name: "index_answers_to_questions_on_question_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "zip_code"
    t.string "departement"
    t.string "region"
    t.string "intercommunalite"
    t.string "population"
    t.string "density"
    t.integer "debt"
    t.string "current_maire"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "canton"
    t.string "code_commune"
    t.string "gentile"
    t.string "coordinates"
    t.string "height"
    t.string "superficy"
    t.string "website"
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_cities_on_user_id"
  end

  create_table "deputies", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "title", null: false
    t.string "profession"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.index ["user_id"], name: "index_deputies_on_user_id"
  end

  create_table "interviews", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "questionnaire_id"
    t.integer "last_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "status_id"
    t.index ["questionnaire_id"], name: "index_interviews_on_questionnaire_id"
    t.index ["status_id"], name: "index_interviews_on_status_id"
    t.index ["user_id"], name: "index_interviews_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "photo"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_photos_on_city_id"
  end

  create_table "program_to_answers", force: :cascade do |t|
    t.bigint "program_id"
    t.bigint "answers_to_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answers_to_question_id"], name: "index_program_to_answers_on_answers_to_question_id"
    t.index ["program_id"], name: "index_program_to_answers_on_program_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_programs_on_category_id"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string "title"
    t.bigint "category_id"
    t.integer "root_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_questionnaires_on_category_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "questionnaire_id"
    t.text "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_id"], name: "index_questions_on_questionnaire_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_programs", force: :cascade do |t|
    t.text "program"
    t.bigint "user_id"
    t.bigint "interview_id"
    t.bigint "question_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_user_programs_on_category_id"
    t.index ["interview_id"], name: "index_user_programs_on_interview_id"
    t.index ["question_id"], name: "index_user_programs_on_question_id"
    t.index ["user_id"], name: "index_user_programs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers_to_questions", "answers"
  add_foreign_key "answers_to_questions", "questions"
  add_foreign_key "cities", "users"
  add_foreign_key "deputies", "users"
  add_foreign_key "interviews", "questionnaires"
  add_foreign_key "interviews", "statuses"
  add_foreign_key "interviews", "users"
  add_foreign_key "photos", "cities"
  add_foreign_key "program_to_answers", "answers_to_questions"
  add_foreign_key "program_to_answers", "programs"
  add_foreign_key "programs", "categories"
  add_foreign_key "questionnaires", "categories"
  add_foreign_key "questions", "questionnaires"
  add_foreign_key "user_programs", "categories"
  add_foreign_key "user_programs", "interviews"
  add_foreign_key "user_programs", "questions"
  add_foreign_key "user_programs", "users"
end
