class AddPublishingToBooks < ActiveRecord::Migration
  def change # then the 'up' and 'down' is accommodated
    add_column :books, :publishing, :string
  end
end
