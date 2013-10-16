class CreateBookstores < ActiveRecord::Migration
  def change
    create_table :bookstores do |t|
      t.string :name
    end

    add_column :bookshelves, :bookstore_id, :integer
  end
end
