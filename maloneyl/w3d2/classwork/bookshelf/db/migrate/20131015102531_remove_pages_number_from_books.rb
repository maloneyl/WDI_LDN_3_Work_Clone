class RemovePagesNumberFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :pages_number # table name, column name
  end

  def down
    add_column :books, :pages_number, :integer # inverse of up, but if you're adding stuff you need to indicate field type
  end
end
