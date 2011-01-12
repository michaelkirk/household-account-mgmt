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

ActiveRecord::Schema.define(:version => 20110106183545) do

  create_table "households", :force => true do |t|
    t.string   "name"
    t.decimal  "balance",    :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.integer  "household_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.decimal  "amount",       :precision => 8, :scale => 2, :null => false
    t.boolean  "credit",                                     :null => false
    t.string   "message"
    t.integer  "household_id",                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
