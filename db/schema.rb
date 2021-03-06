# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_220_327_233_537) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'order_lines', force: :cascade do |t|
    t.bigint 'order_id', null: false
    t.bigint 'product_id', null: false
    t.integer 'quantity'
    t.decimal 'price', precision: 8, scale: 2
    t.decimal 'total', precision: 8, scale: 2
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['order_id'], name: 'index_order_lines_on_order_id'
    t.index ['product_id'], name: 'index_order_lines_on_product_id'
  end

  # Could not dump table "orders" because of following StandardError
  #   Unknown type 'order_status' for column 'order_status'

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.decimal 'price', precision: 8, scale: 2
    t.integer 'stock'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'first_name'
    t.string 'last_name'
    t.string 'address'
    t.boolean 'admin'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'order_lines', 'orders'
  add_foreign_key 'order_lines', 'products'
  add_foreign_key 'orders', 'users'
end
