class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.date :release_date
      t.text :poster
      t.string :director
      t.integer :rating
    end
  end
end
