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

ActiveRecord::Schema.define(:version => 20130630150628) do

  create_table "cart_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.decimal  "price",      :precision => 8, :scale => 2
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "status",     :default => "created"
  end

  create_table "order_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "price"
  end

  create_table "orders", :force => true do |t|
    t.string   "reference"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "address_line_1", :null => false
    t.string   "address_line_2"
    t.string   "zip_code",       :null => false
    t.string   "city",           :null => false
    t.integer  "payment_method"
    t.string   "country"
  end

  add_index "orders", ["reference"], :name => "index_orders_on_reference", :unique => true

  create_table "payment_methods", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.decimal  "price",       :precision => 8, :scale => 2
    t.boolean  "is_active",                                 :default => false
    t.integer  "stock_count",                               :default => 0
    t.text     "abstract"
    t.string   "picture"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "is_admin",        :default => false
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
