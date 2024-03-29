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

ActiveRecord::Schema[7.0].define(version: 2022_02_28_223312) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill_elements", force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.bigint "element_id", null: false
    t.string "original_element", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_bill_elements_on_bill_id"
    t.index ["element_id"], name: "index_bill_elements_on_element_id"
  end

  create_table "bills", force: :cascade do |t|
    t.string "total", array: true
    t.boolean "payed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "element_sales", force: :cascade do |t|
    t.bigint "element_id", null: false
    t.integer "quantity"
    t.decimal "sale_price"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["element_id"], name: "index_element_sales_on_element_id"
  end

  create_table "elements", force: :cascade do |t|
    t.decimal "price"
    t.string "code"
    t.boolean "sale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bill_elements", "bills"
  add_foreign_key "bill_elements", "elements"
  add_foreign_key "element_sales", "elements"
end
