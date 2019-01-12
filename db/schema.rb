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

ActiveRecord::Schema.define(version: 20181206063435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advertisements", force: :cascade do |t|
    t.string "title", null: false
    t.string "app_url", null: false
    t.string "image"
    t.string "hash_01"
    t.string "hash_02"
    t.string "hash_03"
    t.string "hash_04"
    t.string "request_follower"
    t.string "target_sex"
    t.string "target_age"
    t.string "app_category"
    t.text "content", null: false
    t.text "about_function"
    t.text "about_target"
    t.text "about_condition"
    t.text "about_fee", null: false
    t.bigint "user_id"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_advertisements_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "advertisement_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advertisement_id"], name: "index_comments_on_advertisement_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.bigint "advertisement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advertisement_id"], name: "index_conversations_on_advertisement_id"
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id"
    t.index ["sender_id", "recipient_id", "advertisement_id"], name: "index_conversations_on_sender_recipient_and_advertisement_id", unique: true
    t.index ["sender_id"], name: "index_conversations_on_sender_id"
  end

  create_table "conversions", force: :cascade do |t|
    t.integer "diveloper_id"
    t.integer "advertiser_id"
    t.integer "conversation_id"
    t.integer "advertisement_id"
    t.boolean "temporary_confirm", default: false, null: false
    t.boolean "definitive_confirm", default: false, null: false
    t.integer "fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_conversions_on_conversation_id", unique: true
    t.index ["diveloper_id", "advertiser_id", "conversation_id"], name: "index_conversions_on_diveloper_advertiser_and_conversation_id", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "advertisement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "advertisement_id"], name: "index_favorites_on_user_id_and_advertisement_id", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.boolean "read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "provider", default: "", null: false
    t.string "uid", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "icon"
    t.string "twitter"
    t.string "facebook"
    t.string "reset_password_token"
    t.text "content"
    t.integer "sign_in_count", default: 0, null: false
    t.boolean "want_to_advertise", default: true, null: false
    t.boolean "want_to_be_advertised", default: true, null: false
    t.boolean "admin", default: false, null: false
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "reset_password_sent_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
