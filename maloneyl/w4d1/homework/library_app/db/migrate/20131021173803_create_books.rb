class CreateBooks < ActiveRecord::Migration
  def up
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :pages
      t.integer :year
      t.belongs_to :bookshelf
    end

  end

  def down
    drop_table :books
  end
end
