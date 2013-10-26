class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.string :title
      t.string :artist
      t.string :description
      t.integer :price
      t.string :image
      t.integer :gallery_id

      t.timestamps
    end
  end
end
