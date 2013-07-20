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

ActiveRecord::Schema.define(:version => 20130720053055) do

  create_table "checkins", :force => true do |t|
    t.datetime "timestamp"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "players", :force => true do |t|
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.datetime "created"
    t.datetime "modified"
    t.string   "role"
    t.integer  "team_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "avatar"
    t.string   "facebook_uid"
    t.string   "facebook_token"
    t.string   "twitter_uid"
    t.string   "twitter_token"
    t.string   "twitter_secret"
  end

  add_index "players", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "players", ["email"], :name => "index_users_on_email", :unique => true
  add_index "players", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "puzzles", :force => true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.string   "document"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "token"
  end

  create_table "team_invitations", :force => true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "token"
  end

  create_table "teams", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
    t.datetime "created"
    t.datetime "updated"
    t.text     "description"
    t.string   "slogan"
    t.string   "logo"
    t.string   "token"
    t.string   "phone"
    t.boolean  "paid"
  end

  add_index "teams", ["name"], :name => "index_teams_on_name", :unique => true

end
