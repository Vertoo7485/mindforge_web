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

ActiveRecord::Schema[7.1].define(version: 2026_11_11_095103) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "icon"
    t.string "condition_type"
    t.integer "condition_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "budgets", force: :cascade do |t|
    t.string "category"
    t.decimal "amount"
    t.string "period"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "characters", force: :cascade do |t|
    t.integer "level"
    t.integer "xp"
    t.integer "xp_to_next_level"
    t.integer "coins"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "debts", force: :cascade do |t|
    t.string "title"
    t.decimal "total_amount"
    t.decimal "paid_amount"
    t.decimal "monthly_payment"
    t.string "icon"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_debts_on_user_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.string "muscle_group"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "financial_profiles", force: :cascade do |t|
    t.decimal "monthly_income"
    t.decimal "monthly_expenses"
    t.decimal "savings_goal"
    t.string "risk_level"
    t.string "main_goal"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_financial_profiles_on_user_id"
  end

  create_table "habit_completions", force: :cascade do |t|
    t.bigint "habit_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_habit_completions_on_habit_id"
  end

  create_table "habits", force: :cascade do |t|
    t.string "name"
    t.string "frequency"
    t.integer "target_count"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_habits_on_user_id"
  end

  create_table "program_exercises", force: :cascade do |t|
    t.bigint "workout_program_id", null: false
    t.bigint "exercise_id", null: false
    t.integer "sets"
    t.integer "reps"
    t.decimal "weight"
    t.integer "order_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_program_exercises_on_exercise_id"
    t.index ["workout_program_id"], name: "index_program_exercises_on_workout_program_id"
  end

  create_table "savings_goals", force: :cascade do |t|
    t.string "title"
    t.decimal "target_amount"
    t.decimal "current_amount"
    t.date "deadline"
    t.string "icon"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_savings_goals_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "priority"
    t.date "due_date"
    t.boolean "completed"
    t.string "recurrence"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "transaction_type"
    t.decimal "amount"
    t.string "category"
    t.date "date"
    t.string "note"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "user_achievements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "achievement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id"], name: "index_user_achievements_on_achievement_id"
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workout_logs", force: :cascade do |t|
    t.bigint "workout_program_id", null: false
    t.bigint "user_id", null: false
    t.date "date"
    t.integer "duration_minutes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workout_logs_on_user_id"
    t.index ["workout_program_id"], name: "index_workout_logs_on_workout_program_id"
  end

  create_table "workout_programs", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_template", default: false
    t.string "level", default: "beginner"
    t.index ["user_id"], name: "index_workout_programs_on_user_id"
  end

  add_foreign_key "budgets", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "characters", "users"
  add_foreign_key "debts", "users"
  add_foreign_key "exercises", "users"
  add_foreign_key "financial_profiles", "users"
  add_foreign_key "habit_completions", "habits"
  add_foreign_key "habits", "users"
  add_foreign_key "program_exercises", "exercises"
  add_foreign_key "program_exercises", "workout_programs"
  add_foreign_key "savings_goals", "users"
  add_foreign_key "tasks", "users"
  add_foreign_key "transactions", "users"
  add_foreign_key "user_achievements", "achievements"
  add_foreign_key "user_achievements", "users"
  add_foreign_key "workout_logs", "users"
  add_foreign_key "workout_logs", "workout_programs"
  add_foreign_key "workout_programs", "users"
end
