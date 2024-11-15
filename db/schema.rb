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

ActiveRecord::Schema[8.0].define(version: 2024_11_15_160917) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
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
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.text "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time_zone"
    t.index ["email"], name: "index_authors_on_email", unique: true
  end

  create_table "configs", force: :cascade do |t|
    t.string "key", null: false
    t.json "data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_configs_on_key", unique: true
  end

  create_table "pages", force: :cascade do |t|
    t.string "name", null: false
    t.text "markdown"
    t.text "html"
    t.string "template", null: false
    t.text "slug", null: false
    t.boolean "main_menu", default: false
    t.text "og_image_url"
    t.text "image_url"
    t.text "description"
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "exclude_posts_from_home_page", default: false
    t.string "page_type", default: "content", null: false
    t.index ["name"], name: "index_pages_on_name", unique: true
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.text "markdown", null: false
    t.text "html", null: false
    t.text "slug", null: false
    t.text "og_image_url"
    t.text "image_url"
    t.text "description"
    t.text "title"
    t.integer "author_id", null: false
    t.integer "page_id"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "summary"
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["page_id"], name: "index_posts_on_page_id"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "redirects", force: :cascade do |t|
    t.text "from", null: false
    t.text "to", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from"], name: "index_redirects_on_from", unique: true
  end

  create_table "revisions", force: :cascade do |t|
    t.json "data", default: {}, null: false
    t.string "record_type"
    t.integer "record_id"
    t.string "uid"
    t.json "attributes_with_changes", default: {}, null: false
    t.string "revision_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id"], name: "index_revisions_on_record"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "author_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_sessions_on_author_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "posts", "authors"
  add_foreign_key "posts", "pages"
  add_foreign_key "sessions", "authors"
end
