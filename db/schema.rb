# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100228205533) do

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "access_required"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count",     :default => 0
    t.integer  "topics_count",    :default => 0
  end

  create_table "games", :force => true do |t|
    t.string "name"
    t.string "short_name"
    t.string "game_type"
  end

  create_table "news", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parties", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "location"
    t.string   "address"
    t.string   "city"
    t.string   "stateprov"
    t.string   "zip"
    t.float    "price"
    t.integer  "maximum_registrations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prizes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "party_id"
    t.boolean  "paid",                         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paypal_transid", :limit => 17
  end

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsors", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_memberships", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.boolean  "leader",     :default => false
    t.boolean  "active",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "party_id"
    t.text     "description"
    t.boolean  "moderated",   :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "forum_id"
    t.string   "title"
    t.boolean  "locked",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count", :default => 0
    t.integer  "sticky",      :default => 0
  end

  create_table "tournament_registrations", :force => true do |t|
    t.integer  "team_id"
    t.integer  "tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournaments", :force => true do |t|
    t.integer  "game_id"
    t.integer  "party_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_teams"
    t.integer  "team_size"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.text     "signature"
    t.integer  "status",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "verifycode"
    t.integer  "posts_count", :default => 0
    t.text     "bio"
  end

end
