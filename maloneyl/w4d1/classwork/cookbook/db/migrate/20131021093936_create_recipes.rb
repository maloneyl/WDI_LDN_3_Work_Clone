class CreateRecipes < ActiveRecord::Migration
  def up
    create_table :recipes do |t|
      t.string :name
      t.string :course
      t.integer :cooktime
      t.integer :serving_size
      t.text :instructions
      t.text :image
      t.timestamps
    end
  end

  def down
    drop_table :recipes
  end
end
