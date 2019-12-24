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

ActiveRecord::Schema.define(version: 2019_12_23_201551) do

  create_table "candidates", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.date "birthday"
    t.string "scholarity"
    t.string "work_experience"
    t.string "job_interest"
    t.index ["email"], name: "index_candidates_on_email", unique: true
    t.index ["reset_password_token"], name: "index_candidates_on_reset_password_token", unique: true
  end

  create_table "headhunters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_headhunters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_headhunters_on_reset_password_token", unique: true
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "headhunter_id"
    t.string "title"
    t.string "job_description"
    t.string "skills_description"
    t.decimal "salary_min"
    t.decimal "salary_max"
    t.string "job_level"
    t.date "subscription_date"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["headhunter_id"], name: "index_jobs_on_headhunter_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.integer "candidate_id"
    t.integer "headhunter_id"
    t.integer "sent_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_messages_on_candidate_id"
    t.index ["headhunter_id"], name: "index_messages_on_headhunter_id"
  end

  create_table "proposes", force: :cascade do |t|
    t.integer "candidate_id"
    t.integer "headhunter_id"
    t.integer "subscription_id"
    t.datetime "start_date"
    t.decimal "salary"
    t.string "benefit"
    t.string "function"
    t.string "company_expectation"
    t.string "bonus"
    t.boolean "accepted"
    t.string "denial_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_proposes_on_candidate_id"
    t.index ["headhunter_id"], name: "index_proposes_on_headhunter_id"
    t.index ["subscription_id"], name: "index_proposes_on_subscription_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "job_id"
    t.integer "candidate_id"
    t.string "about_candidate"
    t.boolean "featured_profile", default: false
    t.string "denial_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_subscriptions_on_candidate_id"
    t.index ["job_id"], name: "index_subscriptions_on_job_id"
  end

end
