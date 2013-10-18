class CreatePlanets < ActiveRecord::Migration
  def change
    create_table :planets do |t|
      t.string :name
      t.text :image
      t.float :orbit
      t.float :diameter
      t.float :mass
      t.integer :moons, limit: 2
      t.string :planet_type
      t.boolean :rings, null: false, default: false

      t.timestamps
    end
  end
end
