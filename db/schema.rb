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

ActiveRecord::Schema.define(:version => 20120116220134) do

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

  create_table "pages", :force => true do |t|
    t.text     "title"
    t.text     "body"
    t.text     "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
