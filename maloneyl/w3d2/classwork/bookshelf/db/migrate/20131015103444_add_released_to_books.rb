class AddReleasedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :released, :date    
  end
end
