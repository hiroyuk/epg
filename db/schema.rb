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

ActiveRecord::Schema.define(version: 0) do

  create_table "channels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "original_id",         limit: 64
    t.integer  "transport_stream_id"
    t.integer  "original_network_id"
    t.integer  "service_id",                        null: false
    t.text     "name",                limit: 65535, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "programs", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "channel_id"
    t.integer  "original_id"
    t.string   "title",       limit: 256
    t.string   "detail",      limit: 2048
    t.datetime "start"
    t.datetime "end"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
