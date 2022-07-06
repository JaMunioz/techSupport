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

ActiveRecord::Schema[7.0].define(version: 2022_06_07_202659) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.string "comment"
    t.datetime "date_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "ticket_id", null: false
    t.index ["ticket_id"], name: "index_comments_on_ticket_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "executive_assigneds", force: :cascade do |t|
    t.datetime "date_ticket_assigned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "ticket_id", null: false
    t.index ["ticket_id"], name: "index_executive_assigneds_on_ticket_id"
    t.index ["user_id"], name: "index_executive_assigneds_on_user_id"
  end

  create_table "executive_reports", force: :cascade do |t|
    t.float "calification"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "ticket_id", null: false
    t.index ["ticket_id"], name: "index_executive_reports_on_ticket_id"
    t.index ["user_id"], name: "index_executive_reports_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "request"
    t.datetime "date_request"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "ticket_id", null: false
    t.index ["ticket_id"], name: "index_requests_on_ticket_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "responses", force: :cascade do |t|
    t.string "response"
    t.datetime "date_response"
    t.boolean "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "ticket_id", null: false
    t.index ["ticket_id"], name: "index_responses_on_ticket_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.datetime "incident_creation_date"
    t.datetime "date_incident"
    t.datetime "date_ticket_resolution"
    t.string "title"
    t.string "description"
    t.string "priority"
    t.string "status", default: "Sended"
    t.string "tags"
    t.string "documents"
    t.datetime "ticket_deadline"
    t.boolean "assisted"
    t.boolean "reopen"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "telephone"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "tickets"
  add_foreign_key "comments", "users"
  add_foreign_key "executive_assigneds", "tickets"
  add_foreign_key "executive_assigneds", "users"
  add_foreign_key "executive_reports", "tickets"
  add_foreign_key "executive_reports", "users"
  add_foreign_key "requests", "tickets"
  add_foreign_key "requests", "users"
  add_foreign_key "responses", "tickets"
  add_foreign_key "responses", "users"
end
