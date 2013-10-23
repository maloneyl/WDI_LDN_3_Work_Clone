class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.text :content
      t.string :category
      t.belongs_to :author

      t.timestamps
    end
  end
end
