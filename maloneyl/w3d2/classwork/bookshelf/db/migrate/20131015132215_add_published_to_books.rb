class AddPublishedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :published, :boolean
  end
end
