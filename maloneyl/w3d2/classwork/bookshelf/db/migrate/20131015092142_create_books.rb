class CreateBooks < ActiveRecord::Migration

  def up
    create_table :books do |t| # Rails will automatically create a primary key
      t.string :title
      t.integer :pages_number # Rails will change the data type to what your database uses, e.g. postgre's int4 vs. mysql's integer (or something like that)
      t.string :author
      t.text :content
    end
  end

  def down
    drop_table :table # inverse of up
  end
end
