class CreateMoons < ActiveRecord::Migration
  def change
    create_table :moons do |t|
      t.string :name
      t.string :associated_planet
      t.text :image
      t.float :diameter

      t.timestamps
    end
  end
end
