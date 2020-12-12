# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_12_004810) do

  create_table "approval_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.integer "position"
    t.string "is_leaf_node"
    t.integer "page_limit", default: 20
    t.index ["category_id"], name: "index_categories_on_category_id"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "user_id", null: false
    t.bigint "page_forum_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_forum_id"], name: "index_comments_on_page_forum_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "drafts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "category_id", null: false
    t.bigint "approval_status_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "page_id", null: false
    t.bigint "user_id", null: false
    t.string "description"
    t.text "comments"
    t.index ["approval_status_id"], name: "index_drafts_on_approval_status_id"
    t.index ["category_id"], name: "index_drafts_on_category_id"
    t.index ["page_id"], name: "index_drafts_on_page_id"
    t.index ["user_id"], name: "index_drafts_on_user_id"
  end

  create_table "forum_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "page_forum_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_forum_id"], name: "index_forum_users_on_page_forum_id"
    t.index ["user_id"], name: "index_forum_users_on_user_id"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "path"
    t.string "video_path"
    t.string "name"
    t.integer "video_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "read_at"
    t.bigint "page_id"
    t.bigint "comment_id"
    t.bigint "draft_id"
    t.string "is_published"
    t.index ["actor_id"], name: "index_notifications_on_actor_id"
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["draft_id"], name: "index_notifications_on_draft_id"
    t.index ["page_id"], name: "index_notifications_on_page_id"
    t.index ["recipient_id"], name: "index_notifications_on_recipient_id"
  end

  create_table "page_forums", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "page_id"
    t.index ["page_id"], name: "index_page_forums_on_page_id"
    t.index ["user_id"], name: "index_page_forums_on_user_id"
  end

  create_table "page_publish_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "approval_status_id", null: false
    t.bigint "category_id", null: false
    t.text "content_review"
    t.string "title_review"
    t.bigint "category_review"
    t.string "last_user_edit"
    t.string "status"
    t.string "image"
    t.string "description"
    t.text "sanitized_content"
    t.bigint "page_publish_status_id", null: false
    t.bigint "page_forum_id"
    t.text "comments"
    t.string "category_pinned"
    t.string "global_pinned"
    t.datetime "last_edited_at"
    t.bigint "pinned_by_id"
    t.bigint "category_pinned_by_id"
    t.bigint "approved_by_id"
    t.index ["approval_status_id"], name: "index_pages_on_approval_status_id"
    t.index ["approved_by_id"], name: "index_pages_on_approved_by_id"
    t.index ["category_id"], name: "index_pages_on_category_id"
    t.index ["category_pinned_by_id"], name: "index_pages_on_category_pinned_by_id"
    t.index ["page_forum_id"], name: "index_pages_on_page_forum_id"
    t.index ["page_publish_status_id"], name: "index_pages_on_page_publish_status_id"
    t.index ["pinned_by_id"], name: "index_pages_on_pinned_by_id"
    t.index ["user_id"], name: "index_pages_on_user_id"
  end

  create_table "pdfs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "path", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "logo"
    t.string "smtp_address"
    t.string "smtp_port"
    t.string "smtp_username"
    t.string "smtp_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "server_ip"
  end

  create_table "user_levels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_level_id", null: false
    t.datetime "last_login"
    t.string "first_name"
    t.string "last_name"
    t.bigint "user_status_id", null: false
    t.string "email"
    t.index ["user_level_id"], name: "index_users_on_user_level_id"
    t.index ["user_status_id"], name: "index_users_on_user_status_id"
  end

  create_table "videos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.bigint "image_id"
    t.text "description"
    t.index ["image_id"], name: "index_videos_on_image_id"
  end

  add_foreign_key "categories", "categories"
  add_foreign_key "comments", "page_forums"
  add_foreign_key "comments", "users"
  add_foreign_key "drafts", "approval_statuses"
  add_foreign_key "drafts", "categories"
  add_foreign_key "drafts", "pages"
  add_foreign_key "drafts", "users"
  add_foreign_key "forum_users", "page_forums"
  add_foreign_key "forum_users", "users"
  add_foreign_key "notifications", "comments", on_delete: :cascade
  add_foreign_key "notifications", "drafts"
  add_foreign_key "notifications", "pages", on_delete: :cascade
  add_foreign_key "page_forums", "pages", on_delete: :cascade
  add_foreign_key "page_forums", "users"
  add_foreign_key "pages", "approval_statuses"
  add_foreign_key "pages", "categories"
  add_foreign_key "pages", "page_forums", on_delete: :cascade
  add_foreign_key "pages", "page_publish_statuses"
  add_foreign_key "pages", "users"
  add_foreign_key "pages", "users", column: "approved_by_id"
  add_foreign_key "pages", "users", column: "category_pinned_by_id"
  add_foreign_key "pages", "users", column: "pinned_by_id"
  add_foreign_key "users", "user_levels"
  add_foreign_key "users", "user_statuses"
  add_foreign_key "videos", "images"
end
