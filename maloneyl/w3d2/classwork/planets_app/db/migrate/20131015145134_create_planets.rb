class CreatePlanets < ActiveRecord::Migration
  def change
    create_table :planets do |t|
      t.string :name
      t.text :image
      t.float :orbit
      t.float :diameter
      t.float :mass
      t.integer :moons, limit: 2 # 2 means smallint, which is 2 bytes with a max value of 32767; we're using limit here to save memory
      t.string :planet_type
      t.boolean :rings, null: false, default: false # null: false means it can't be blank, then let's also set default to false
      t.timestamps
    end
  end
end
