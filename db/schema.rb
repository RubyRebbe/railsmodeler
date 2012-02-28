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

ActiveRecord::Schema.define(:version => 20120224050217) do

  create_table "apps", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "database"
  end

  create_table "kassociations", :force => true do |t|
    t.string   "typus"
    t.text     "description"
    t.integer  "source_id"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "kassociations", ["source_id"], :name => "index_kassociations_on_source_id"
  add_index "kassociations", ["target_id"], :name => "index_kassociations_on_target_id"

  create_table "kattributes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "klass_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "typus"
  end

  add_index "kattributes", ["klass_id"], :name => "index_attributes_on_klass_id"

  create_table "klasses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

end
