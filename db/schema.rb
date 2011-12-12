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

ActiveRecord::Schema.define(:version => 20111212160751) do

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

  create_table "users", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "email"
    t.string   "github"
    t.integer  "github_id"
    t.string   "uid"
    t.string   "twitter"
    t.string   "website"
    t.string   "description"
    t.boolean  "admin",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
