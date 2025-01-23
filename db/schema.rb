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

ActiveRecord::Schema[8.0].define(version: 2024_12_14_172139) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.integer "language_1"
    t.integer "language_2"
    t.integer "level_number"
    t.boolean "enable_audio"
    t.jsonb "conversation"
    t.text "audio_path"
    t.integer "tokens_conversation"
    t.text "custom_topic"
    t.text "automatic_title_topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monologues", force: :cascade do |t|
    t.integer "language_1"
    t.integer "language_2"
    t.integer "level_number"
    t.boolean "enable_audio"
    t.jsonb "monologue"
    t.text "audio_path"
    t.integer "tokens_monologue"
    t.text "custom_topic"
    t.text "automatic_title_topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
