class CreateBookshelves < ActiveRecord::Migration
  def up
    create_table :bookshelves do |t|
      t.string :category
      t.belongs_to :library
    end

  end

  def down
    drop_table :bookshelves
  end
end
