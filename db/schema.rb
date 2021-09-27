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

ActiveRecord::Schema.define(version: 20_210_927_111_826) do
  create_table 'bookings', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'meeting_room_id'
    t.datetime 'start_time'
    t.datetime 'end_time'
    t.date 'date'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['meeting_room_id'], name: 'index_bookings_on_meeting_room_id'
    t.index ['user_id'], name: 'index_bookings_on_user_id'
  end

  create_table 'meeting_rooms', force: :cascade do |t|
    t.string 'name'
    t.integer 'capacity'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'is_available', default: true
    t.boolean 'has_wifi', default: false
    t.boolean 'has_projector', default: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'first_name'
    t.string 'last_name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'bookings', 'meeting_rooms'
  add_foreign_key 'bookings', 'users'
end
