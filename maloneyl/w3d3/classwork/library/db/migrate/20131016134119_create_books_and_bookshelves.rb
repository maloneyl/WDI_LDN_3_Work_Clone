class CreateBooksAndBookshelves < ActiveRecord::Migration
  
  def up
    create_table :bookshelves do |t|
      t.string "name"
      t.integer "quantity"
    end

    create_table :books do |t|
      t.string "title"
      t.integer "number_of_pages"
      t.belongs_to :bookshelf # this will create a field named bookshelf_id (this is just whatever name you have there plus an underscore plus id, no other magic)
    end
  end

  def down
  end
end
