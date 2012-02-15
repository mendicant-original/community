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

ActiveRecord::Schema.define(:version => 20120214183417) do

  create_table "activities", :force => true do |t|
    t.integer  "author_id"
    t.string   "title"
    t.string   "slug"
    t.text     "body"
    t.boolean  "registration_open",                          :null => false
    t.boolean  "participation_moderated",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",                :default => false, :null => false
    t.boolean  "allow_discussion",        :default => false, :null => false
    t.text     "discussion_list_name"
  end

  create_table "activity_registrations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.boolean  "approved",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.integer  "author_id"
    t.boolean  "highlight"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "posted_to_twitter", :default => false, :null => false
  end

  create_table "discussion_lists", :force => true do |t|
    t.integer  "activity_id"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "learning_materials", :force => true do |t|
    t.text     "name"
    t.text     "description"
    t.text     "url"
    t.text     "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.text     "title"
    t.text     "body"
    t.text     "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "protected",  :default => false, :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.text     "name",                            :null => false
    t.text     "description"
    t.text     "slug",                            :null => false
    t.text     "source_url"
    t.boolean  "core_project", :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "readings", :force => true do |t|
    t.string   "readable_type"
    t.integer  "readable_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "readings", ["user_id", "readable_id", "readable_type"], :name => "index_readings_on_user_id_and_readable_id_and_readable_type", :unique => true
  add_index "readings", ["user_id"], :name => "index_readings_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "email"
    t.string   "github"
    t.integer  "github_id"
    t.string   "uid"
    t.string   "twitter"
    t.string   "website"
    t.boolean  "admin",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

end
