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

ActiveRecord::Schema[8.0].define(version: 2024_12_20_000006) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "question_options", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "correct", default: false
    t.bigint "question_id", null: false
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id", "correct"], name: "index_question_options_on_question_id_and_correct"
    t.index ["question_id", "position"], name: "index_question_options_on_question_id_and_position"
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string "title", null: false
    t.string "code", null: false
    t.text "description"
    t.integer "duration_minutes", default: 30
    t.integer "total_questions", default: 0
    t.boolean "active", default: true
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_questionnaires_on_active"
    t.index ["code"], name: "index_questionnaires_on_code", unique: true
    t.index ["user_id"], name: "index_questionnaires_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "enunciation", null: false
    t.bigint "questionnaire_id", null: false
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_id", "position"], name: "index_questions_on_questionnaire_id_and_position"
    t.index ["questionnaire_id"], name: "index_questions_on_questionnaire_id"
  end

  create_table "user_answer_histories", force: :cascade do |t|
    t.bigint "user_result_id", null: false
    t.bigint "question_id", null: false
    t.bigint "question_option_id", null: false
    t.boolean "correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["correct"], name: "index_user_answer_histories_on_correct"
    t.index ["question_id"], name: "index_user_answer_histories_on_question_id"
    t.index ["question_option_id"], name: "index_user_answer_histories_on_question_option_id"
    t.index ["user_result_id", "question_id"], name: "index_user_answer_histories_on_user_result_id_and_question_id", unique: true
    t.index ["user_result_id"], name: "index_user_answer_histories_on_user_result_id"
  end

  create_table "user_results", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "questionnaire_id", null: false
    t.integer "score", default: 0
    t.string "grade", default: "F"
    t.datetime "submitted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade"], name: "index_user_results_on_grade"
    t.index ["questionnaire_id"], name: "index_user_results_on_questionnaire_id"
    t.index ["submitted_at"], name: "index_user_results_on_submitted_at"
    t.index ["user_id", "questionnaire_id"], name: "index_user_results_on_user_id_and_questionnaire_id", unique: true
    t.index ["user_id"], name: "index_user_results_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "question_options", "questions"
  add_foreign_key "questionnaires", "users"
  add_foreign_key "questions", "questionnaires"
  add_foreign_key "user_answer_histories", "question_options"
  add_foreign_key "user_answer_histories", "questions"
  add_foreign_key "user_answer_histories", "user_results"
  add_foreign_key "user_results", "questionnaires"
  add_foreign_key "user_results", "users"
end
