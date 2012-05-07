# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120502123825) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "age"
    t.string   "gender"
    t.string   "remote_ip"
    t.string   "comment"
    t.integer  "nude_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "uniq_key"
  end

  create_table "free_board_comments", :force => true do |t|
    t.integer  "age"
    t.string   "gender"
    t.string   "remote_ip"
    t.string   "comment"
    t.integer  "free_board_id"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uniq_key"
  end

  create_table "free_board_likes", :force => true do |t|
    t.string   "remote_ip"
    t.integer  "free_board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uniq_key"
  end

  create_table "free_boards", :force => true do |t|
    t.integer  "age"
    t.string   "gender"
    t.string   "remote_ip"
    t.string   "title"
    t.text     "contents"
    t.integer  "category_id"
    t.integer  "check_count",        :default => 0
    t.integer  "comment_count",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "nude_report_likes", :force => true do |t|
    t.string   "remote_ip"
    t.integer  "nude_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uniq_key"
  end

  create_table "nude_reports", :force => true do |t|
    t.string   "title"
    t.string   "a"
    t.string   "b"
    t.string   "c"
    t.string   "d"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "check_count",      :default => 0
    t.integer  "comment_count",    :default => 0
    t.string   "report_type"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "uniq_key"
    t.integer  "vote_count"
    t.integer  "man_vote_count",   :default => 0
    t.integer  "woman_vote_count", :default => 0
    t.integer  "age"
    t.string   "gender"
  end

  create_table "report_images", :force => true do |t|
    t.integer  "position"
    t.integer  "nude_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "age"
    t.string   "gender"
    t.string   "remote_ip"
    t.string   "answer"
    t.integer  "nude_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uniq_key"
  end

end
