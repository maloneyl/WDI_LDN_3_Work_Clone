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

ActiveRecord::Schema.define(:version => 20131016153405) do

  create_table "authors", :force => true do |t|
    t.string "firstname"
    t.string "lastname"
  end

  create_table "authors_books", :id => false, :force => true do |t|
    t.integer "author_id"
    t.integer "book_id"
  end

  create_table "books", :force => true do |t|
    t.string  "title"
    t.integer "number_of_pages"
    t.integer "bookshelf_id"
  end

  create_table "bookshelves", :force => true do |t|
    t.string  "name"
    t.integer "quantity"
    t.integer "bookstore_id"
  end

  create_table "bookstores", :force => true do |t|
    t.string "name"
  end

end
