class CreateQuantities < ActiveRecord::Migration
  def up
    create_table :quantities do |t|
      t.belongs_to  :recipe
      t.belongs_to  :ingredient
      t.string      :description
      t.decimal      :price
      t.decimal      :quantity
      t.string      :measurement
    end

    drop_table :ingredients_recipes
  end

  def down

    drop_table :quantities

    create_table :ingredients_recipes, :id => false do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
    end
  end
end
