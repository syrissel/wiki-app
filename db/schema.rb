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

ActiveRecord::Schema.define(version: 2020_01_22_162330) do

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
    t.index ["category_id"], name: "index_categories_on_category_id"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "path"
    t.string "video_path"
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
    t.index ["approval_status_id"], name: "index_pages_on_approval_status_id"
    t.index ["category_id"], name: "index_pages_on_category_id"
    t.index ["user_id"], name: "index_pages_on_user_id"
  end

  create_table "user_levels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "level"
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
    t.index ["user_level_id"], name: "index_users_on_user_level_id"
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
  add_foreign_key "pages", "approval_statuses"
  add_foreign_key "pages", "categories"
  add_foreign_key "pages", "users"
  add_foreign_key "users", "user_levels"
  add_foreign_key "videos", "images"
end
