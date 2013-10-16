class CreateAuthors < ActiveRecord::Migration

  def change
    create_table :authors do |t|
      t.string "firstname"
      t.string "lastname"
    end

    create_table :authors_books, id: false do |t|  # i.e. no primary/specific key
      t.integer :author_id
      t.integer :book_id
    end
  end

end
