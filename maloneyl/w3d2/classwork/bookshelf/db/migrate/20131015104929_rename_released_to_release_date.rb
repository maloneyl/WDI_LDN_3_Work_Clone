class RenameReleasedToReleaseDate < ActiveRecord::Migration
  def up
    rename_column :books, :released, :release_date
  end

  def down
    rename_column :books, :release_date, :released # inverse of 'up' 
  end
end
